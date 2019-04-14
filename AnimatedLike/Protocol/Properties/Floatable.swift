//
//  Floatable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/14/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Floatable {
    func addFloatingView(with image: UIImage)
    var minDimension: CGFloat {get set}
    var maxDimension: CGFloat {get set}
    
}

extension Floatable where Self: UIView {
    
    var minDimension: CGFloat {
        set { minDimension = newValue }
        get { return AnimatableConstants.floatableMinDimension }
    }
    
    var maxDimension: CGFloat {
        set { maxDimension = newValue }
        get { return AnimatableConstants.floatableMaxDimension }
    }
    
    private func getRandomPath() -> UIBezierPath? {
        
        let height: CGFloat = 300
        guard let superView = self.superview,
            let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self) else { return nil }
        
        let center = AnimatableHelper.getCenter(for: self, withRespectToIts: superView, on: parentControllerView)
        
        let path = UIBezierPath()
        path.move(to: center)
        
        let randomXShift =  getMultiplier() * CGFloat(drand48() * 120)
        let endPoint = CGPoint(x: center.x - randomXShift, y: center.y - height)
        let cp1 = CGPoint(x: center.x - randomXShift, y: center.y - 80)
        let cp2 = CGPoint(x: center.x + randomXShift, y: center.y - 150)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    func addFloatingView(with image: UIImage) {
        
        guard let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self),
            let path = getRandomPath() else { return }
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.random()
        let dimension = getRandomDimension()
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let groupAnimation = getAnimationGroup(for: path)
        groupAnimation.delegate = AnimationDelegate(didStart: nil, didStop: {
            imageView.removeFromSuperview()
        })
        imageView.layer.add(groupAnimation, forKey: nil)
        parentControllerView.addSubview(imageView)
    }
    
    private func getMultiplier() -> CGFloat {
        return drand48() > 0.5 ? 1 : -1
    }
    
    private func getRandomDimension() -> CGFloat {
        return  minDimension + CGFloat(drand48()) * maxDimension
    }
    
    private func getPositionAnimation(for path: UIBezierPath) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = path.cgPath
        positionAnimation.fillMode = CAMediaTimingFillMode.forwards
        return positionAnimation
    }
    
    private func getOpacityAniamtion() ->  CAKeyframeAnimation {
        let opacityAniamtion = CAKeyframeAnimation(keyPath: "opacity")
        opacityAniamtion.values = [1.0, 0.5,  0]
        return opacityAniamtion
    }
    
    private func getAnimationGroup(for path: UIBezierPath) -> CAAnimationGroup {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [getPositionAnimation(for: path), getOpacityAniamtion()]
        groupAnimation.duration = 2 + drand48() * 3
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        groupAnimation.isRemovedOnCompletion = false
        return groupAnimation
    }
    
}

