//
//  FriendsViewCell.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit

class FriendsViewCell: UITableViewCell {
    
    
    @IBOutlet weak var friendsLabel: UILabel!
    
    @IBOutlet weak var friendsAvatar: AvatarView! 
    
   private var imageCache = NSCache<NSString, UIImage>()
    
    var userModel: UserItem? {
        didSet {
            setup()
        }
    }
    
    override func prepareForReuse() {
        friendsAvatar.setup(avatarImage: nil)
    }
    
    private func setup() {
        
        guard let userModel = userModel else { return }
        let fullName = "\(userModel.firstName) \(userModel.lastName)"
        friendsLabel.text = fullName
        
        ImageCaching.shared.fetchImage(withURL: userModel.photo50) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.friendsAvatar.setup(avatarImage: image!)
            }
        }
    }
}
