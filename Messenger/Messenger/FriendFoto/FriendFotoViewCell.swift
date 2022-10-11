//
//  FriendFotoViewCell.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit

class FriendFotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendFotoImageView: UIImageView!
   
     var photoModel: ItemPhoto? {
        didSet {
            setup()
        }
    }
    var imageCache = ImageCaching.shared
    
    private func setup() {
        
        guard let photoModel = photoModel else { return }
   
        imageCache.fetchImage(withURL: photoModel.sizes[2].url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.friendFotoImageView.image = image
            }
        }
    }
    
}
