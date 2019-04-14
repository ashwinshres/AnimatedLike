//
//  FlyAble.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Flyable: class {
    func fly(to destinationView: UIView, didReachDestination: @escaping () -> ())
}

extension Flyable where Self: UIView {
    
    func fly(to destinationView: UIView, didReachDestination: @escaping () -> ()) {
        
         guard let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self),
            let destinationSuperView = destinationView.superview
            else { return }
        let destionationCenter = AnimatableHelper.getCenter(for: destinationView, withRespectToIts: destinationSuperView, on: parentControllerView)
        
        UIView.animate(withDuration: AnimatableConstants.flyAnimationDuration, animations: {
            self.center = destionationCenter
            parentControllerView.layoutIfNeeded()
        }) { _ in
            didReachDestination()
            self.removeFromSuperview()
        }
    }
   
    
}
