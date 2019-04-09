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
    
}
