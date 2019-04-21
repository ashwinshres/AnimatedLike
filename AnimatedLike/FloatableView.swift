//
//  FloatableView.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/14/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

class FloatableView: UIView, Tapable, Floatable, Pulsable {
    
    var numberOfTapsRequired: Int = 1
    var generateFlyAble: Bool = false
    
    var numberOfPulses: Float = 10
    
}
