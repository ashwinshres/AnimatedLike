//
//  BounceAble.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol BounceAble: class {
    func bounce(didBounce: @escaping () -> ())
    var bounceScale: CGFloat {set get}
    var initialAlpha: CGFloat {set get}
}

extension BounceAble where Self: UIView {
    
    var bounceScale: CGFloat {
        set { bounceScale = newValue }
        get { return AnimatableConstants.bounceScale }
    }
    
    var initialAlpha: CGFloat {
        set { initialAlpha = newValue }
        get { return AnimatableConstants.bounceViewInitialAlpha }
    }
    
    func bounce(didBounce: @escaping () -> ()) {
        
        guard let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self) else { return }
        self.alpha = self.initialAlpha
        UIView.animate(withDuration: AnimatableConstants.bounceAnimationDuration, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: self.bounceScale, y: self.bounceScale)
            parentControllerView.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: AnimatableConstants.bounceAnimationDuration, animations: {
                self.transform = .identity
                parentControllerView.layoutIfNeeded()
            }, completion: { _ in
                didBounce()
            })
        }
    }
    
}
