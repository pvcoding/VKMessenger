//
//  CommentButton.swift
//  Messenger
//
//  Created by Polly on 20.04.2022.
//

import UIKit

class CommentButton: UIButton {

    private var labelCommentCount: UILabel!
    private var commentIcon: UIImageView!
    var commentCount = 0 {
        didSet {
            labelCommentCount.text = String(commentCount)
        }
    }
    
    private var isTapped: Bool = false
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap() {
        changeCommentState()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGestureRecognizer)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapGestureRecognizer)
        self.setupView()
    }
 
    private func setupView() {
        labelCommentCount = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 14))
        labelCommentCount.font = labelCommentCount.font.withSize(14)
        labelCommentCount.textAlignment = .right
        labelCommentCount.textColor = .black
        self.addSubview(labelCommentCount)

        
        commentIcon = UIImageView(frame: CGRect(x: 35, y: 0, width: 14, height: 14))
        commentIcon.image = UIImage(named: "comment")
        self.addSubview(commentIcon)
    }
    
    
    private func changeCommentState() {
        if isTapped {
            commentCount -= 1
            isTapped = !isTapped
        } else {
            commentCount += 1
            isTapped = !isTapped
        }
    }

}
