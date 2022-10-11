//
//  FriendsViewController.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit
import RealmSwift
import Alamofire

class FriendsViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    private var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    private var users: Results<UserItem>? {
        let users: Results<UserItem>? = realmManager?.getObjects()
        return users
    }
    
    private var friendSection = [Section]()
    private var filteredFriendSection = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let users = users, users.isEmpty {
            loadFriendsData()
        } else if let users = users, !users.isEmpty{

            self.friendSection = sortedFriends(friends: users)
            self.filteredFriendSection = friendSection
            self.searchBar.text = ""
            self.tableView.reloadData()
        }
    }
    
    private func loadFriendsData() {
       
        DispatchQueue.global(qos: .userInitiated).async {
            self.networkManager.loadFriends() { [weak self] (users) in
                
                DispatchQueue.main.async {
                    
                    do {
                        try self?.realmManager?.add(objects: users)
                        if let realmUsers = self?.users {
                            self?.friendSection = (self?.sortedFriends(friends: realmUsers))!
                            self?.filteredFriendSection = self?.friendSection ?? []
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func sortedFriends(friends: Results<UserItem>) -> [Section] {
        
        let userDictionary = Dictionary(grouping: friends, by:
                                            {$0.firstName.prefix(1)})
        var section = userDictionary.map{Section(title: String($0.key), items: $0.value)}
        section.sort{$0.title < $1.title}
        return section
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoto" {
            if let vc = segue.destination as? FriendFotoViewController {
                
                let friendIndex = tableView.indexPathForSelectedRow!
                vc.userFotoId = filteredFriendSection[friendIndex.section].items[friendIndex.item].id
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriendSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriendSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .blue
        label.alpha = 0.2
        label.textColor = .white
        label.text = "   \(filteredFriendSection[section].title)"
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsViewCell
        
        let userModel = filteredFriendSection[indexPath.section].items[indexPath.row]
        cell.userModel = userModel
        
        return cell
    }
    
}

// MARK: SearchBarDelegate


extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.lowercased()
        
        if searchText == "" {
            filteredFriendSection = friendSection
        } else {
            let firstNamePredicate = NSPredicate(format: "firstName CONTAINS[CD] %@", text)
            let lastNamePredicate = NSPredicate(format: "lastName CONTAINS[CD] %@", text)
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [firstNamePredicate, lastNamePredicate])
            
            let filteredItems = users?.filter(compoundPredicate)
            
            filteredFriendSection = sortedFriends(friends: filteredItems!)
        }
        self.tableView.reloadData()
    }
    
}
