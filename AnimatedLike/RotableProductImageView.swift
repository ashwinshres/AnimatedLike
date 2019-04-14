//
//  RotableProductImageView.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/14/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class RotableProductImageView: UIImageView, Rotatable {

    var images: [UIImage] = []
    var isAutoAnimatable: Bool = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        isUserInteractionEnabled = true
    }
    
    func initiateRotation() {
        images = getProductImages()
        rotate()
    }
    
    private func getProductImages() -> [UIImage] {
        var images = [UIImage]()
        for i in 1...36 {
            images.append(UIImage(named: "img\(i).jpg")!)
        }
        return images
    }
    

}
