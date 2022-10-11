//
//  CloudIndicator.swift
//  Messenger
//
//  Created by Polly on 01.07.2022.
//

import UIKit

class CloudIndicator: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        startAnimating()
    }
    
     func startAnimating() {
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        let cloudView = CloudView()
        cloudView.frame = CGRect(x: 30, y: 80, width: 110, height: 80)
        cloudView.center = self.center
        cloudView.backgroundColor = .clear
        
        let gradient = CAGradientLayer()
        gradient.colors = [
                UIColor.blue.cgColor,
                UIColor.cyan.cgColor
            ]
        gradient.frame = cloudView.bounds

        let shapeMask = CAShapeLayer()
        shapeMask.path = cloudView.getPath().cgPath
        gradient.mask = shapeMask

        cloudView.layer.addSublayer(gradient)
        self.addSubview(cloudView)
        
    }
    
     func stopAnimating() {
        self.removeFromSuperview()
    }
    
//    func loadView() {
////        let view = UIView()
//        self.backgroundColor = .black
//
//        let myView = CloudView()
//        myView.frame = CGRect(x: 30, y: 80, width: 110, height: 80)
//        myView.backgroundColor = .clear
//
//        let gradient = CAGradientLayer()
//        gradient.colors = [
//                UIColor.blue.cgColor,
//                UIColor.cyan.cgColor
//            ]
//        gradient.frame = myView.bounds
//
//        let shapeMask = CAShapeLayer()
//        shapeMask.path = myView.getPath().cgPath
//        gradient.mask = shapeMask
//
//        myView.layer.addSublayer(gradient)
//        view.addSubview(myView)
//
//        self.view = view
//    }
   
}


class CloudView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let path: UIBezierPath = getPath()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 2.0
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(shape)
        
        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = UIColor.yellow.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.position = CGPoint(x: 20, y: 40)
        circleLayer.cornerRadius = 10
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = path.cgPath
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        followPathAnimation.speed = 0.1
        followPathAnimation.repeatCount = Float.infinity
        circleLayer.add(followPathAnimation, forKey: nil)
        
        self.layer.addSublayer(circleLayer)
    
    }
    
    func getPath() -> UIBezierPath {
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 40))
        path.addCurve(to: CGPoint(x: 40, y: 35), controlPoint1: CGPoint(x: 20, y: 25), controlPoint2: CGPoint(x: 35, y: 25))
        
        path.addCurve(to: CGPoint(x: 70, y: 35), controlPoint1: CGPoint(x: 45, y: 20), controlPoint2: CGPoint(x: 65, y: 20))
        
        path.addCurve(to: CGPoint(x: 90, y: 40), controlPoint1: CGPoint(x: 75, y: 25), controlPoint2: CGPoint(x: 90, y: 25))
        
        path.addCurve(to: CGPoint(x: 20, y: 40), controlPoint1: CGPoint(x: 92, y: 70), controlPoint2: CGPoint(x: 18, y: 70))
        
        path.close()
        return path
    }
}
