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
        let desstionationCenter = self.getDestinationCenter(for: destinationView,
                                                            withRespectToIts : destinationSuperView,
                                                            on: parentControllerView)
        
        UIView.animate(withDuration: AnimatableConstants.flyAnimationDuration, animations: {
            self.center = desstionationCenter
            parentControllerView.layoutIfNeeded()
        }) { _ in
            didReachDestination()
            self.removeFromSuperview()
        }
    }
    
    private func getDestinationCenter(for destinationView: UIView,
                                      withRespectToIts parent: UIView,
                                      on parentControllerView: UIView) -> CGPoint {
        let destinationPosition = parentControllerView.convert(destinationView.frame, from: parent)
        let destinationCenterX = destinationPosition.origin.x + (destinationPosition.size.width / 2.0)
        let destinationCenterY = destinationPosition.origin.y + (destinationPosition.size.height / 2.0)
        return CGPoint(x: destinationCenterX, y: destinationCenterY)
    }
    
}
