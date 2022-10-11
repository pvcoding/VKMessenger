//
//  AvatarView.swift
//  Messenger
//
//  Created by Polly on 12.01.2022.
//

import UIKit


class AvatarView: UIView {

     var colorOfShadow: UIColor = UIColor.red
     var offsetOfShadow: CGSize = CGSize(width: 3, height: 3)
     var opacityOfShadow: Float = 0.7
     var radiusOfShadow: CGFloat = 4

    
   func setup(avatarImage: UIImage?) {
    
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = colorOfShadow.cgColor
        self.layer.shadowOffset = offsetOfShadow
        self.layer.shadowOpacity = opacityOfShadow
        self.layer.shadowRadius = radiusOfShadow
        self.layer.cornerRadius = self.bounds.height / 2

        let borderView = UIView()
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = self.frame.height / 2
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 0.7
        borderView.layer.masksToBounds = true
        self.addSubview(borderView)


        let avatarImageView = UIImageView()
        avatarImageView.image = avatarImage
        avatarImageView.frame = borderView.bounds
        borderView.addSubview(avatarImageView)
    }
}

