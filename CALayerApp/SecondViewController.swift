//
//  SecondViewController.swift
//  CALayerApp
//
//  Created by Duxxless on 12.02.2022.
//

import UIKit
import Spring

class SecondViewController: UIViewController {
    
    let secondView = UIView()
    let opacityLayer = CALayer()
    let imageView = UIImageView()
    let shapeLayer = CAShapeLayer()
    let secondShapeLayer = CAShapeLayer()
    let springView = SpringView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setSecondeView()
        setConfigurationImageView()
        scaleAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setSecondeView() {
        navigationItem.hidesBackButton = true
        title = ""
        self.secondView.backgroundColor = .darkGray
        secondView.frame = view.frame
        imageView.layer.add(setOpacityLayer(), forKey: nil)
        secondView.addSubview(imageView)
        view.addSubview(secondView)
    }
    
    func setOpacityLayer() -> CABasicAnimation {
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        opacityAnimation.duration = 0.5
        
        return opacityAnimation
    }
    
    func setConfigurationImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "congrat")
        imageView.image = image
        imageView.center = view.center
        UIView.animateKeyframes(withDuration: 1,
                                     delay: 0,
                                     options: [.autoreverse, .repeat]) {

            self.imageView.frame.size.width -= 80
            self.imageView.frame.size.width += 80
            
            self.imageView.frame.size.height -= 80
            self.imageView.frame.size.height += 80
        }
    }
    
    func scaleAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 1.5
        scaleAnimation.duration = 0.5
        scaleAnimation.autoreverses = true
        scaleAnimation.isRemovedOnCompletion = false
        //scaleAnimation.fillMode = .backwards
        
        imageView.layer.add(scaleAnimation, forKey: nil)
    }
}
