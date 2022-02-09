//
//  ViewController.swift
//  CALayerApp
//
//  Created by Duxxless on 05.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let positionAnimationLayer = CALayer()
    let opacityAnimationLayer = CALayer()
    let viewTwo = UIView()
    let shapeLayer = CAShapeLayer()
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradient = setGradient()
        view.layer.insertSublayer(gradient, at: 0)
        
        viewTwo.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.view.addSubview(viewTwo)
        
//        // сжатия и сужение представление
//        viewTwo.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//
//        // смещение представление
//        viewTwo.transform = CGAffineTransform(translationX: 40, y: 40)
//
//        // разворот представление
//        viewTwo.transform = CGAffineTransform(rotationAngle: 0.3)
        
        positionAnimationLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        positionAnimationLayer.backgroundColor = UIColor.systemRed.cgColor
        positionAnimationLayer.cornerRadius = positionAnimationLayer.bounds.size.width/2
        self.viewTwo.layer.addSublayer(positionAnimationLayer)
        
        
        opacityAnimationLayer.frame = CGRect(x: 20, y: 40, width: 100, height: 50)
        opacityAnimationLayer.cornerRadius = opacityAnimationLayer.bounds.width/5
        self.viewTwo.layer.addSublayer(opacityAnimationLayer)
        opacityAnimationLayer.backgroundColor = UIColor.systemYellow.cgColor
        
        // Button
        button.addTarget(self, action: #selector(showEditing), for: .touchUpInside)
        button = UIButton(type: .roundedRect)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .lightGray
        button.setTitle("Press", for: .normal)
        button.setTitle("Great", for: .highlighted)
        button.frame = CGRect(x: viewTwo.bounds.size.width/2 + viewTwo.bounds.origin.x, y: viewTwo.frame.size.height/2, width: 120, height: 50)
        button.layer.cornerRadius = button.bounds.width/5
        button.layer.shadowRadius = 5
        button.alpha = 0
        viewTwo.addSubview(button)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            
            self.setPositionAnimation()
            self.opacityAnimation(myDuration: 0.5)
            self.setTransformAnimation()
            
            
        }
        
    }
}

extension ViewController {
    
    // CAGradientLayer
    func setGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor]
        gradient.frame = self.view.bounds
        
        return gradient
    }
    
    // CABasicAnimation - "position"
    func setPositionAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: positionAnimationLayer.frame.origin.x + positionAnimationLayer.frame.size.width/2,
                                      y: positionAnimationLayer.frame.origin.y + positionAnimationLayer.frame.size.height/2)
        animation.toValue = CGPoint(x: 350 , y: 830)
        animation.duration = 5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        positionAnimationLayer.add(animation, forKey: nil)
    }
    
    
    func opacityAnimation(myDuration: Double) {
        
        let label = CABasicAnimation(keyPath: "opacity")
        
        label.fromValue = 0
        label.toValue = 1
        label.duration = myDuration
        label.fillMode = .forwards
        label.isRemovedOnCompletion = false
        //label.autoreverses = true
       // label.repeatCount = 1
        
        opacityAnimationLayer.add(label, forKey: nil)
        button.layer.add(label, forKey: nil)
        
    }
    
    // TransformAnimation
    func setTransformAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale.xy")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.duration = 0.5
        animation.repeatCount = 4
        opacityAnimationLayer.add(animation, forKey: "position")
    }
    
    @objc func showEditing() {
        print("TAP!")
        
    }
    
}
