//
//  NewsTableViewController.swift
//  Messenger
//
//  Created by Polly on 18.04.2022.
//

import UIKit

protocol TableControllerProtocol: AnyObject {
    var newsResponse: NewsResponse? {get set}
    func reloadData()
}

class NewsTableViewController: UITableViewController, TableControllerProtocol {
    
    var newsResponse: NewsResponse?
    let operationQueue = OperationQueue()
    let networkManager = NetworkManager.shared
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = networkManager.getNewsUrl(token: SessionInfo.shared.token)
        operationQueue.qualityOfService = .userInitiated
        
        let getDataOperation = GetDataOperation(url: url)
        operationQueue.addOperation(getDataOperation)
        
    
        let parseData = ParseData()
        parseData.addDependency(getDataOperation)
        operationQueue.addOperation(parseData)
    
        let reloadTableController = ReloadTableController(controller: self)
        reloadTableController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableController)

    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.items.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        guard let newsResponse = newsResponse else {return UITableViewCell()}
        cell.setupViewWith(item: newsResponse.items[indexPath.row], groups: newsResponse.groups, profiles: newsResponse.profiles)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
