//
//  Likeable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Tapable {
    func tap(with customView: UIView?,didTap:  @escaping (FlyableView) -> ())
}

extension Tapable where Self: UIView {
    
    func tap(with customView: UIView?,didTap:  @escaping (FlyableView) -> ()) {
        let tapGesture = UITapGestureRecognizer { (gesture) in
            guard let parentControllerView = AnimatableHelper.getParentControllerBaseView(for: self) else { return }
            let tapAbleView = self.getNewFlyableView(withCenterAt: gesture.location(in: parentControllerView))
            if let view = customView {
                tapAbleView.addSubview(view)
            } else {
                let imageView = UIImageView(frame: CGRect(origin: .zero, size: tapAbleView.frame.size))
                imageView.image = #imageLiteral(resourceName: "heart.png")
                tapAbleView.addSubview(imageView)
            }
            parentControllerView.addSubview(tapAbleView)
            tapAbleView.bounce {
                didTap(tapAbleView)
            }
        }
        tapGesture.numberOfTapsRequired = AnimatableConstants.numberOftapRequired
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    private func getNewFlyableView(withCenterAt point: CGPoint) -> FlyableView {
        let tapableView = FlyableView(frame: CGRect.zero)
        tapableView.center = point
        tapableView.frame.size = AnimatableConstants.flyableViewSize
        tapableView.alpha = 1
        return tapableView
    }
 
}
