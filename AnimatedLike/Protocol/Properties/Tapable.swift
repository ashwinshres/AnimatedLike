//
//  Likeable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Tapable {
    func tap(with customView: UIView?,didTap:  @escaping (FlyableView?) -> ())
    var numberOfTapsRequired: Int {set get}
    var generateFlyAble: Bool { set get}
}

extension Tapable where Self: UIView {
    
    var numberOfTapsRequired: Int {
        set { numberOfTapsRequired = newValue }
        get { return AnimatableConstants.numberOfTapRequired }
    }
    
    var generateFlyAble: Bool {
        set { generateFlyAble = newValue }
        get { return AnimatableConstants.generateFlyable }
    }
    
    func tap(with customView: UIView?,didTap:  @escaping (FlyableView?) -> ()) {
        let tapGesture = UITapGestureRecognizer { (gesture) in
            if !self.generateFlyAble {
                didTap(nil)
                return
            }
            guard let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self) else { return }
            let flyableView = self.getNewFlyableView(withCenterAt: gesture.location(in: parentControllerView))
            if let view = customView {
                flyableView.addSubview(view)
            } else {
                let imageView = UIImageView(frame: CGRect(origin: .zero, size: flyableView.frame.size))
                imageView.image = #imageLiteral(resourceName: "heart.png")
                flyableView.addSubview(imageView)
            }
            parentControllerView.addSubview(flyableView)
            flyableView.bounce {
                didTap(flyableView)
            }
        }
        tapGesture.numberOfTapsRequired = numberOfTapsRequired
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    private func getNewFlyableView(withCenterAt point: CGPoint) -> FlyableView {
        let flyableView = FlyableView(frame: CGRect.zero)
        flyableView.center = point
        flyableView.frame.size = AnimatableConstants.flyableViewSize
        flyableView.alpha = 0
        return flyableView
    }
 
}
