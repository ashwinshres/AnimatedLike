//
//  Shakeable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/13/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Shakeable: ShakeableX, ShakeableY {
    
}

extension Shakeable where Self: UIView  {
   
}

protocol ShakeableX {
    var duration: Double {set get}
    var repeatcount: Float {set get}
    var distance: CGFloat {set get}
}

extension ShakeableX where Self: UIView  {
    
    var duration: Double {
        set { duration = newValue }
        get { return AnimatableConstants.shakeDuration }
    }
    
    var repeatcount: Float {
        set { repeatcount = newValue }
        get { return AnimatableConstants.shakeCount }
    }
    
    var distance: CGFloat {
        set { distance = newValue }
        get { return AnimatableConstants.shakeDistance }
    }
    
    func shakeAlongXAxis() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatcount
        animation.autoreverses = true
        animation.fromValue =  NSValue(cgPoint: CGPoint(x: center.x - distance, y: center.y))
        animation.toValue =  NSValue(cgPoint: CGPoint(x: center.x + distance, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
}


protocol ShakeableY {
    var duration: Double {set get}
    var repeatcount: Float {set get}
    var distance: CGFloat {set get}
}

extension ShakeableY where Self: UIView  {
    
    var duration: Double {
        set { duration = newValue }
        get { return AnimatableConstants.shakeDuration }
    }
    
    var repeatcount: Float {
        set { repeatcount = newValue }
        get { return AnimatableConstants.shakeCount }
    }
    
    var distance: CGFloat {
        set { distance = newValue }
        get { return AnimatableConstants.shakeDistance }
    }
    
    func shakeAlongYAxis() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatcount
        animation.autoreverses = true
        animation.fromValue =  NSValue(cgPoint: CGPoint(x: center.x, y: center.y - distance))
        animation.toValue =  NSValue(cgPoint: CGPoint(x: center.x, y: center.y + distance))
        layer.add(animation, forKey: "position")
    }
    
}
