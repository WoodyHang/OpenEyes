//
//  Contain.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

protocol Containable {
    func containerView() -> UIView?
}

extension Containable {
    func latestMask() -> UIView? {
        var latestMask: UIView? = nil
        if let container = containerView() {
            for subview in container.subviews {
                if let _ = subview as? Maskable {
                    latestMask = subview
                }
            }
        }
        
        return latestMask
    }
}
