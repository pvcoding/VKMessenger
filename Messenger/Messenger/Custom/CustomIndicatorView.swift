//
//  CustomIndicatorView.swift
//  Messenger
//
//  Created by Polly on 25.04.2022.
//

import UIKit
import Foundation

class CustomIndicatorView: UIView {
    
    private let circle1 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    private let circle2 = UIView(frame: CGRect(x: 20, y: 0, width: 15, height: 15))
    private  let circle3 = UIView(frame: CGRect(x: 40, y: 0, width: 15, height: 15))
    

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        setupView()
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
        self.backgroundColor = .clear
        self.circle1.backgroundColor = .blue
        self.circle1.layer.cornerRadius = self.circle1.bounds.height / 2
        self.circle1.clipsToBounds = true
        self.circle1.alpha = 0.2
        self.addSubview(circle1)
        
        self.circle2.backgroundColor = .blue
        self.circle2.alpha = 0.2
        self.circle2.layer.cornerRadius = self.circle2.bounds.height / 2
        self.circle2.clipsToBounds = true
        self.addSubview(circle2)
        
        self.circle3.backgroundColor = .blue
        self.circle3.alpha = 0.2
        self.circle3.layer.cornerRadius = self.circle3.bounds.height / 2
        self.circle3.clipsToBounds = true
        self.addSubview(circle3)
       
    }
    
    func startAnimating() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.circle1.alpha = 1
            
        }
        UIView.animate(withDuration: 1, delay: 0.5, options: [.repeat, .autoreverse]) {
            self.circle2.alpha = 1
        }
        UIView.animate(withDuration: 1, delay: 1, options: [.repeat, .autoreverse]) {
            self.circle3.alpha = 1
        }

        
    }
    
    private func stopAnimating() {
        self.isHidden = true
    }
    
}
