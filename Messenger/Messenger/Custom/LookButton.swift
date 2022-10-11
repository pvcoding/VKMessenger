//
//  LookButton.swift
//  Messenger
//
//  Created by Polly on 20.04.2022.
//

import UIKit

class LookButton: UIButton {

    private var labelLookCount: UILabel!
    private var lookIcon: UIImageView!
    var lookCount = 0 {
        didSet {
            labelLookCount.text = String(lookCount)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    private func setupView() {
        labelLookCount = UILabel(frame: CGRect(x: 16, y: 0, width: 40, height: 14))
        labelLookCount.font = labelLookCount.font.withSize(14)
        labelLookCount.textColor = .black
        self.addSubview(labelLookCount)

        lookIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        lookIcon.image = UIImage(named: "look")
        self.addSubview(lookIcon)
    }
    
}
