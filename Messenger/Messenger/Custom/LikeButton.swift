//
//  LikeButtonControl.swift
//  Messenger
//
//  Created by Polly on 17.01.2022.
//

import UIKit

class LikeButton: UIButton {

    
    var likeCount = 0 {
        didSet {
            likeLabel.text = String(likeCount)
        }
    }
    var isTapped: Bool = false
    private var heartIcon : UIImageView!
    private var likeLabel : UILabel!
    
    private let likedImage = UIImageView(image: UIImage(named: "full_heart"))
    private let unlikedImage = UIImageView(image: UIImage(named: "empty_heart"))
    

    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap() {
        changeLikeState()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapGestureRecognizer)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGestureRecognizer)
        setupView()
    }

    private func setupView() {
        heartIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        unlikedImage.frame = heartIcon.bounds
        heartIcon.addSubview(unlikedImage)
        self.addSubview(heartIcon)
        
        likeLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 40, height: 14))
        likeLabel.text = String(likeCount)
        likeLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(likeLabel)
    }
   

    private func changeLikeState() {
        
        if isTapped {
            likeLabel.textColor = .black
            likeCount -= 1
            UIImageView.transition(from: likedImage, to: unlikedImage,
            duration: 0.3,
            options: .transitionFlipFromRight)
            isTapped = !isTapped
        } else {
            likeLabel.textColor = .red
            likeCount += 1
            likedImage.frame = heartIcon.bounds
            UIImageView.transition(from: unlikedImage, to: likedImage,
            duration: 0.3,
            options: .transitionFlipFromLeft)
            isTapped = !isTapped
        }
    }
}
