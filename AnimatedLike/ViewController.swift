//
//  ViewController.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var likeableView: LikeAbleView!
    @IBOutlet var bounceableView: BounceAbleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        likeableView.tap(with: nil) { (flyAbleView) in
            // want the animated like view to fly to the like button in your design?
            flyAbleView.fly(to: self.bounceableView, didReachDestination: {
                // want the like view in your design to bounce??
                self.bounceableView.bounce {
                    // do anything after the bounce is completed
                }
            })
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


}

