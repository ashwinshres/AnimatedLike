//
//  ProductRotatable.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/14/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

protocol Rotatable {
    func rotate()
    var images: [UIImage] {set get}
    var isAutoAnimatable: Bool {set get}
}

extension Rotatable where Self: UIImageView {

    var images: [UIImage] {
        set { images = newValue }
        get { return [] }
    }
    
    var isAutoAnimatable: Bool {
        set { isAutoAnimatable = newValue }
        get { return true }
    }
    
    
    func rotate() {
        addPanGesture()
        setUpAutoAnimation()
    }
    
    private func addPanGesture() {
        var lastPoint: CGPoint = CGPoint.zero
        let sensitivity: CGFloat = 15.0
        var currentIndex = 0
        var isPanning = false
        
        let gesture = UIPanGestureRecognizer { (recognizer) in
            guard let recognizer = recognizer as? UIPanGestureRecognizer else { return }
            
            let currentPoint = recognizer.location(in: self)
            if recognizer.state == .began{
                isPanning = true
                self.stopAutoAnimation()
                lastPoint = currentPoint
            } else if recognizer.state == .changed {
                isPanning = true
                let velocity = recognizer.velocity(in: self)
                if velocity.x > 0 && currentPoint.x > lastPoint.x + sensitivity {
                    currentIndex = currentIndex > 0 ? (currentIndex - 1) : self.images.count - 1
                    lastPoint = currentPoint
                } else {
                    if currentPoint.x < lastPoint.x - sensitivity {
                        currentIndex = currentIndex < (self.images.count - 1) ? (currentIndex + 1) : 0
                        lastPoint = currentPoint
                    }
                }
            } else if recognizer.state == .ended {
                isPanning = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if !isPanning {
                        self.setUpAutoAnimation()
                    }
                }
            }
            self.image = self.images[currentIndex]
        }
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    private func setUpAutoAnimation() {
        if self.isAutoAnimatable {
            animationImages = images
            animationDuration = 1.8
            startAnimating()
        } else {
            stopAutoAnimation()
        }
    }
    
    private func stopAutoAnimation() {
        stopAnimating()
    }
    
}
