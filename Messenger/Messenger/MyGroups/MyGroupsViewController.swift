//
//  MyGroupsViewController.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit
import RealmSwift
import PromiseKit
import Alamofire

class MyGroupsViewController: UITableViewController {
    
    
    private let realmManager = RealmManager.shared
    private let networkManager = NetworkManager.shared
    private var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    private var groups: Results<ItemGroup>? {
        let groups: Results<ItemGroup>? = realmManager?.getObjects()
        return groups?.sorted(byKeyPath: "name", ascending: true)
    }
    private var groupsNotificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadGroupsData()
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupsController = segue.source as! AllGroupsViewController
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                
                let group = allGroupsController.groups[indexPath.row]
                joinGroup(groupID: String(group.id))
                
                DispatchQueue.main.async {
                    do {
                        let addedGroup = ItemGroup()
                        addedGroup.name = group.name
                        addedGroup.id = group.id
                        addedGroup.photo50 = group.photo50
                        
                        try self.realmManager?.add(object: addedGroup)
                        self.animateTableView()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    deinit {
        groupsNotificationToken?.invalidate()
        
    }
    
    private func addToken() {
        groupsNotificationToken = groups?.observe{ [ weak self ] (changes) in
            switch changes {
            case .initial:
                break
            case .update( _, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                self?.tableView.beginUpdates()
                
                let delitionIndexPaths = deletions.map { IndexPath(row: $0, section: 0)}
                let insertionIndexPaths = insertions.map { IndexPath(row: $0, section: 0)}
                let modificationIndexPaths = modifications.map { IndexPath(row: $0, section: 0)}
                self?.tableView.deleteRows(at: delitionIndexPaths, with: .fade)
                self?.tableView.insertRows(at: insertionIndexPaths, with: .automatic)
                self?.tableView.reloadRows(at: modificationIndexPaths, with: .automatic)
                
                self?.tableView.endUpdates()
                
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadGroupsData() {
        
        let apiRouterStructure = APIRouterStructer(apiRouter: .groups)
        let groupsPromise: Promise<Groups> = session.request(apiRouterStructure,on: DispatchQueue.global(qos: .userInitiated))
        
        firstly {
            
            groupsPromise
        }
        .then { [weak self] (groups) -> Promise<Groups> in
            guard let self = self else { throw InternalError.unexpected }
            do {
                try self.realmManager?.add(objects: groups.response.items)
            } catch {
                print(error.localizedDescription)
            }
            return Promise<Groups>.value(groups)
        }
        .catch { [ weak self] (error) in
            guard let self = self else { return }
            print("Error Groups")
        }
        .finally {
            print("Finally done")
        }
        
    }
    
    private func joinGroup(groupID: String) {
        networkManager.joinGroup(token: SessionInfo.shared.token, groupID: groupID)
    }
    
    private func leaveGroup(groupID: String, completion: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: "Удалить группу?", message: "Вы покинете группу на оф сайте ВК", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Удалить из ВК", style: .default) { (action) in
            self.networkManager.leaveGroup(token: SessionInfo.shared.token, groupID: groupID)
            completion(true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        completion(false)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func animateTableView() {
        
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 2.5,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                cell.transform = CGAffineTransform.identity
            }
            delay += 1
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupsCell", for: indexPath) as! MyGroupsViewCell
 
        let model = groups?[indexPath.row]
        cell.groupModel = model
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = String((groups?[indexPath.row].id)!)
            leaveGroup(groupID: id) { [weak self]
                (response) in
                if response == true {
                    do {
                        try self?.realmManager?.delete(object: (self?.groups?[indexPath.row])!)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }  
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
