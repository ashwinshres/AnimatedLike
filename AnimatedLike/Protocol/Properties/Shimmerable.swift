//
//  Shimmerable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/19/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Shimmerable: class {
    func shimmer()
    func stopShimmer()
}

extension Shimmerable where Self: UIView {

    func shimmer() {
        
        for animateView in getSubViewsForAnimate() {
            animateView.clipsToBounds = true
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            animateView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.5
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            animation.repeatCount = .infinity
            
            gradientLayer.add(animation, forKey: "")
        }
    }
    
    func stopShimmer() {
        for animateView in getSubViewsForAnimate() {
            animateView.layer.mask = nil
            animateView.layer.removeAllAnimations()
        }
    }
    
    private func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in self.subviewsRecursive() {
            obj.append(objView)
        }
        return obj
    }
    
}
