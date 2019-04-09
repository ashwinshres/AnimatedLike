//
//  TapHandler.swift
//  AnimatedLike
//
//  Created by Insight Workshop on 4/9/19.
//  Copyright © 2019 Skyway Innovation. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    
    public convenience init(callback: @escaping (_ recognizer: UIGestureRecognizer) -> ()) {
        let wrapper = CallbackWrapper(callback)
        self.init(target: wrapper, action: #selector(CallbackWrapper.callCallback(_:)))
        
        // retaint callback wrapper
        let key = UnsafeMutablePointer<Int8>.allocate(capacity: 1);
        objc_setAssociatedObject(self, key, wrapper, .OBJC_ASSOCIATION_RETAIN)
    }
    
    class CallbackWrapper {
        var callback : (_ recognizer: UIGestureRecognizer) -> ();
        init(_ callback: @escaping (_ recognizer: UIGestureRecognizer) -> ()) {
            self.callback = callback;
        }
        @objc public func callCallback(_ recognizer: UIGestureRecognizer) {
            self.callback(recognizer);
        }
    }
    
}
