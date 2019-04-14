//
//  ViewController.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var rotateAbleProductView: RotableProductImageView!
    @IBOutlet var likeFloatableView: FloatableView!
    @IBOutlet var likeableView: LikeAbleView!
    @IBOutlet var bounceableView: BounceAbleView!
    
    var images = [#imageLiteral(resourceName: "angry.png"), #imageLiteral(resourceName: "haha.png"), #imageLiteral(resourceName: "floatingHeart.png"), #imageLiteral(resourceName: "smile.png"), #imageLiteral(resourceName: "wow.png")]
    var isAutoGenerating = false
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        rotateAbleProductView.initiateRotation()
        
        likeableView.tap(with: nil) { (flyAbleView) in
            // want the animated like view to fly to the like button in your design?
            flyAbleView?.fly(to: self.bounceableView, didReachDestination: {
                // want the like view in your design to bounce??
                self.bounceableView.bounce {
                    // do anything after the bounce is completed
                    // make be shake the view??
                    self.likeableView.shakeAlongXAxis()
                }
            })
        }
        
        likeFloatableView.tap(with: nil) { _ in
            let random = Int(arc4random_uniform(5 - 0) + 0)
            self.likeFloatableView.addFloatingView(with:  self.images[random])
        }
        
        //you can send your own custom view
        /*
        let customView = UIView(frame: CGRect(origin: .zero, size: AnimatableConstants.flyableViewSize))
        customView.backgroundColor = .green
        
        likeableView.tap(with: nil) { (flyAbleView) in
            flyAbleView.fly(to: self.bounceableView, didReachDestination: {
                self.bounceableView.bounce {
                }
            })
        }
         */
    }

    @IBAction func onAutoGenerateLikeTapped(_ sender: UIButton) {
        isAutoGenerating = !isAutoGenerating
        
        sender.setTitle(isAutoGenerating ? "Stop Auto generation" : "Auto generate floating like", for: .normal)
        if isAutoGenerating {
            timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { (timer) in
                let random = Int(arc4random_uniform(5 - 0) + 0)
                self.likeFloatableView.addFloatingView(with:  self.images[random])
            }
        } else {
            timer.invalidate()
            timer = nil
        }
    }
    
}

