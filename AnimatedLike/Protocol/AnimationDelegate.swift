//
//  AnimationDelegate.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/14/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class AnimationDelegate: NSObject, CAAnimationDelegate {
    typealias AnimationCallback = (() -> Void)
    
    let didStart: AnimationCallback?
    let didStop: AnimationCallback?
    
    init(didStart: AnimationCallback?, didStop: AnimationCallback?) {
        self.didStart = didStart
        self.didStop = didStop
    }
    
    internal func animationDidStart(_ anim: CAAnimation) {
        didStart?()
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        didStop?()
    }
}
