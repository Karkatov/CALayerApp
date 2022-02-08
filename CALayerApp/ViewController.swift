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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = setGradient()
        view.layer.insertSublayer(gradient, at: 0)
        

        
    
        
        positionAnimationLayer.backgroundColor = UIColor.systemRed.cgColor
        positionAnimationLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        positionAnimationLayer.cornerRadius = positionAnimationLayer.bounds.size.width/2
        self.view.layer.addSublayer(positionAnimationLayer)
        
        viewTwo.frame = CGRect(x: view.layer.bounds.origin.x, y: view.layer.bounds.origin.y, width: 50, height: 50)
                viewTwo.layer.cornerRadius = viewTwo.bounds.size.width/2
                viewTwo.backgroundColor = .black
                self.viewTwo.layer.addSublayer(opacityAnimationLayer)
                self.view.addSubview(viewTwo)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.setPositionAnimation()
            self.viewTwo.layer.opacityAnimation(myDuration: 0.2)
        }
    
    }
    
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
    
}
