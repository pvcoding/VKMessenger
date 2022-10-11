//
//  MainViewController.swift
//  Messenger
//
//  Created by Polly on 27.09.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showWelcomeAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "VKLoginViewController") as? VKLoginViewController else { return }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    private func showWelcomeAnimation() {
        
        let time = 5.0
        let indicator = CloudIndicator(frame: self.view.bounds)
 
        let label = UILabel(frame: CGRect(x: self.view.bounds.midX - 100, y: self.view.bounds.midY - 200, width: 200, height: 60))
        label.textAlignment = .center
        label.font = label.font.withSize(40)
        label.text = "WELCOME"
        label.textColor = .white
        
        UIView.animate(withDuration: time) {
            label.alpha = 0
            indicator.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        self.view.addSubview(indicator)
        self.view.addSubview(label)
        
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (t) in
            indicator.stopAnimating()
            label.removeFromSuperview()
        }
    }

}
