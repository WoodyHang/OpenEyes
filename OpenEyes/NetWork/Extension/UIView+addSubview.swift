//
//  UIView+addSubview.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Inner addSubView for Bamboots, making autolayout when addSubView
    ///
    /// - Parameters:
    ///   - subview: view to be added
    ///   - insets: insets between subview and view itself
     internal func ex_addSubView(_ subview: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String : UIView] = ["subview": subview]
        let layoutStringH: String = "H:|-" + String(describing: insets.left) + "-[subview]-"
            + String(describing: insets.right) + "-|"
        let layoutStringV: String = "V:|-" + String(describing: insets.top) + "-[subview]-"
            + String(describing: insets.bottom) + "-|"
        let contraintsH: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views
        )
        let contraintsV: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: layoutStringV, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views
        )
        
        self.addConstraints(contraintsH)
        self.addConstraints(contraintsV)
    }
}

// MARK: - Making `UIView` conforms to `Containable`
extension UIView: Containable {
    /// Return self as container for `UIView`
    ///
    /// - Returns: `UIView` itself
    @objc public func containerView() -> UIView? {
        return self
    }
}
