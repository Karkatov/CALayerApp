//
//  ViewController.swift
//  CALayerApp
//
//  Created by Duxxless on 05.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let viewTwo = UIView()
    let positionAnimationLayer = CALayer()
    let opacityAnimationLayer = CALayer()
    var startShapeLayer: CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 20.0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = .none
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.systemCyan.cgColor
        return shapeLayer
    }
    
    var overShapeLayer: CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 20.0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = .none
        shapeLayer.strokeEnd = 0.0
        shapeLayer.strokeColor = UIColor.white.cgColor
        return shapeLayer
    }
    
    let imageView = UIImageView()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let gradient = setGradient()
        view.layer.insertSublayer(gradient, at: 0)

        setViewTwo()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            
            self.setUserImageView()
            self.imageView.layer.add(self.opacityAnimation(myDuration: 1), forKey: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.2) {
            
            self.setConfigurationShapeLayer(self.startShapeLayer)
            self.setConfigurationShapeLayer(self.overShapeLayer)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
            self.setButton()
            self.button.layer.add(self.opacityAnimation(myDuration: 1), forKey: nil)
        }
    }
}

extension ViewController {
    
    // Set View
    func setViewTwo() {
       
        viewTwo.frame = CGRect(x: 0, y: 0,
                               width: view.frame.size.width,
                               height: view.frame.size.height)
        self.view.addSubview(viewTwo)
    }
    
    // Button
    func setButton() {
        
        button = UIButton(type: .roundedRect)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitle("START", for: .normal)
        button.setTitle("💬💬💬", for: .highlighted)
        button.bounds.size.width = 120
        button.bounds.size.height = 50
        button.frame = CGRect(x: (viewTwo.bounds.size.width - button.bounds.size.width)/2,
                              y: (viewTwo.bounds.size.height - button.bounds.size.height)/1.2, width: button.bounds.size.width, height: button.bounds.size.height)
        button.layer.cornerRadius = button.bounds.width/5
        button.layer.shadowRadius = 15
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(showEditing), for: .touchUpInside)
        viewTwo.addSubview(button)
    }
    
    @objc func showEditing() {
        print("TAP!")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
        
            self.overShapeLayer.strokeEnd += 0.1
            print(self.overShapeLayer.strokeEnd)
        }
    }
    
       func setUserImageView() {
           let image = UIImage(named: "worker")
           imageView.image = image
           imageView.bounds.size.width = 160
           imageView.bounds.size.height = 160
           imageView.frame = CGRect(x: (view.bounds.size.width - imageView.bounds.size.width)/2,
                                    y: (view.bounds.size.height + imageView.bounds.size.height)/6,
       width: 160, height: 160)
           imageView.clipsToBounds = true
           imageView.layer.borderWidth = 6
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.bounds.size.width/2
    
           viewTwo.addSubview(imageView)
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
    
    // CABasicAnimation - "opacity"
    func opacityAnimation(myDuration: Double) -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = myDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        //animation.autoreverses = true
        // animation.repeatCount = 1
        return animation
    }
    
    // CABasicAnimation - "transform.scale"
    func setTransformAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale.xy")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        animation.repeatCount = 4
        
        opacityAnimationLayer.add(animation, forKey: "position")
    }
    
    // UIShapeLayer
    func setConfigurationShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = viewTwo.frame
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.viewTwo.bounds.width/2 - 100,
                              y: self.viewTwo.bounds.height/2))
        path.addLine(to: CGPoint(x: self.viewTwo.bounds.width/2 + 100,
                                 y: self.viewTwo.bounds.height/2))
        shapeLayer.path = path.cgPath
        viewTwo.layer.addSublayer(shapeLayer)
    }
}

