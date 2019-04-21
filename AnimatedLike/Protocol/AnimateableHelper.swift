//
//  UIViewHelper.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class AnimatableHelper {

    static func getParentControllerBaseView(for view: UIView) -> UIView? {
       return AnimatableHelper.getPrentController(for: view)?.view
    }
    
    static func getPrentController(for view: UIView) -> UIViewController? {
        var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = view
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
        return parentViewController
    }
    
    static func getCenter(for view: UIView,
                                      withRespectToIts parent: UIView,
                                      on parentControllerView: UIView) -> CGPoint {
        let destinationPosition = parentControllerView.convert(view.frame, from: parent)
        let destinationCenterX = destinationPosition.origin.x + (destinationPosition.size.width / 2.0)
        let destinationCenterY = destinationPosition.origin.y + (destinationPosition.size.height / 2.0)
        return CGPoint(x: destinationCenterX, y: destinationCenterY)
    }
    
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}


extension UIView {
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
}
