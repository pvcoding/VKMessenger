//
//  AllGroupsViewController.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit

class AllGroupsViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    var groups = [ItemSearchGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroups", for: indexPath) as! AllGroupsViewCell
        
        if groups.count > 0 {
            cell.allGroupsLabel.text = groups[indexPath.row].name
            if let url = URL(string: groups[indexPath.row].photo50) {
                let data = (try? Data(contentsOf: url))!
                cell.allGroupsAvatarView.setup(avatarImage: UIImage(data: data)!)
            }
        }
 
        return cell
    }
    

}

extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText != "" {
            DispatchQueue.global(qos: .userInitiated).async {
                NetworkManager.shared.loadSearchGroups(token: SessionInfo.shared.token, searchText: searchText) { [ weak self] (groups) in
                    
                    self?.groups = groups
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        } else {
            self.groups = []
            self.tableView.reloadData()
        }
        
        
        
    }
}
