//
//  Pulsable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/21/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Pulsable {
    
    var initialPulseScale: Float {set get}
    var nextPulseAfter: TimeInterval { set get}
    var animationDuration: TimeInterval {set get}
    var radius: CGFloat { set get}
    var numberOfPulses: Float {set get}
    var pulseColor: UIColor {set get}
    
    func pulsate()
    func stopPulsating()
    
}

extension Pulsable where Self: UIView {

    var initialPulseScale: Float {
        set { initialPulseScale = newValue }
        get { return AnimatableConstants.initialPulseScale }
    }
    
    var nextPulseAfter: TimeInterval {
        set { nextPulseAfter = newValue }
        get { return AnimatableConstants.nextPulseAfter }
    }
    
    var radius: CGFloat {
        set { radius = newValue }
        get { return AnimatableConstants.radius }
    }
    
    var animationDuration: TimeInterval {
        set { animationDuration = newValue }
        get { return AnimatableConstants.animationDuration }
    }

    var numberOfPulses: Float {
        set { numberOfPulses = newValue }
        get { return AnimatableConstants.numberOfPulses }
    }
    
    var pulseColor: UIColor {
        set { pulseColor = newValue }
        get { return AnimatableConstants.pulseColor }
    }
    
    func pulsate() {
        guard let controllerBaseView = AnimatableHelper.getParentControllerBaseView(for: self),
            let superView = superview else {
            return
        }
        let center = AnimatableHelper.getCenter(for: self, withRespectToIts: superView, on: controllerBaseView)
        
        let layer = createPulsingLayer(with: center)
        controllerBaseView.layer.insertSublayer(layer, below: self.layer)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let animationGroup = self.setupAnimationGroup()
            DispatchQueue.main.async {
                layer.add(animationGroup, forKey: "pulse")
            }
        }
    }
    
    func stopPulsating() {
        guard let controllerBaseView = AnimatableHelper.getParentControllerBaseView(for: self) else {
                return
        }
        for layer in controllerBaseView.layer.sublayers ?? [] {
            if layer.animationKeys()?.contains("pulse") ?? false {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    private func createPulsingLayer(with center: CGPoint) -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = pulseColor.cgColor
        layer.contentsScale = UIScreen.main.scale
        layer.opacity = 0
        layer.position =  center
        layer.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        layer.cornerRadius = radius
        return layer
    }
    
    private func createScaleAnimation () -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    private func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        return opacityAnimation
    }
    
    private func setupAnimationGroup() -> CAAnimationGroup {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses
       let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animationGroup.timingFunction = defaultCurve
        animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
        return animationGroup
    }
    
}
