//
//  UIControl+Loadable.swift
//  Pods
//
//  Created by ZhengYidong on 08/01/2017.
//
//

import UIKit

// MARK: - Making `UIControl` conforms to `Loadable`
extension UIControl: Loadable {

    func maskContainer() -> Containable? {
        return self
    }

    func mask() -> Maskable? {
        let mask = ActivityIndicator()
        mask.backgroundColor = backgroundColor
        mask.color = tintColor
        return mask
    }

    /// Making it disabled when network request begins
    @objc func begin() {
        isEnabled = false
        show()
    }

    /// Making it enabled when the last network request ends
    @objc func end() {
        if let latestMask = self.maskContainer()?.latestMask() {
            if false == latestMask.isHidden {
                isEnabled = true
            }
        }
        hide()
    }
}
