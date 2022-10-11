//
//  ShareButton.swift
//  Messenger
//
//  Created by Polly on 20.04.2022.
//

import UIKit

class ShareButton: UIButton {

    private var labelShareCount: UILabel!
    private var shareIcon: UIImageView!
    var shareCount = 0 {
        didSet {
            labelShareCount.text = String(shareCount)
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
        changeShareState()
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
        labelShareCount = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 14))
        labelShareCount.font = labelShareCount.font.withSize(14)
        labelShareCount.textAlignment = .right
        labelShareCount.textColor = .black
        self.addSubview(labelShareCount)

        
        shareIcon = UIImageView(frame: CGRect(x: 35, y: 0, width: 14, height: 14))
        shareIcon.image = UIImage(named: "share1")
        self.addSubview(shareIcon)
    }
    
    private func changeShareState() {
        if isTapped {
            shareCount -= 1
            isTapped = !isTapped
        } else {
            shareCount += 1
            isTapped = !isTapped
        }
    }

}
