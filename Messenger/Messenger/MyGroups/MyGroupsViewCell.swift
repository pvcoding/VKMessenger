//
//  MyGroupsViewCell.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit

class MyGroupsViewCell: UITableViewCell {

    @IBOutlet weak var myGroupsLabel: UILabel!
   
    
    @IBOutlet weak var myGroupsView: AvatarView!
    
    var groupModel: ItemGroup? {
        didSet {
            setup()
        }
    }

    
    private func setup() {
        guard let groupModel = groupModel else { return }
        
        myGroupsLabel.text = groupModel.name
        
        ImageCaching.shared.fetchImage(withURL: groupModel.photo50) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.myGroupsView.setup(avatarImage: image!)
            }
        }
    }
}
