//
//  Load.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit


class MyHUD: BaseLoadable {
    init(container: Containable, message: String = "") {
        messageMine = message
        containerMine = container
    }
    
    var containerMine: Containable
    var messageMine: String
    
    func begin() {
        if let container = containerMine as? UIView {
            let hud = MBProgressHUD.showAdded(to: container, animated: true)
            
            hud.label.text = messageMine
        }
        
        
    }
    
    
    func end() {
        if let container = containerMine as? UIView {
            MBProgressHUD.hide(for: container, animated: true)
        }
        
        
    }
}
extension LoadType: Loadable {
    
    func maskContainer() -> Containable? {
        switch self {
        case .default(let container):
            return container
        case .none:
            return nil
        }
    }
    
    func begin() {
        show()
    }
    
    func end() {
        hide()
    }
}

enum LoadType {
    case none
    case `default`(container: Containable)
    
}

protocol BaseLoadable {
    func begin()
    
    func end()
}

protocol Loadable: BaseLoadable {
    
    func mask() -> Maskable?
    
    func inset() -> UIEdgeInsets
    
    func maskContainer() -> Containable?
    
}

extension Loadable {
    
    func mask() -> Maskable? {
        return MaskView()
    }
    
    func inset() -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
    func maskContainer() -> Containable? {
        return nil
    }
    
    func begin() {
        show()
    }
    
    func end() {
        hide()
    }
    
    func show() {
        if let mask = self.mask() as? UIView {
            var isHidden = false
            if let _ = self.maskContainer()?.latestMask() {
                isHidden = true
            }
            
            self.maskContainer()?.containerView()?.ex_addSubView(mask, insets: self.inset())
            mask.isHidden = isHidden
            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    func hide() {
        if let latestMask = self.maskContainer()?.latestMask() {
            latestMask.removeFromSuperview()
            
            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                if false == latestMask.isHidden {
                    scrollView.isScrollEnabled = true
                }
            }
        }
    }
    
}

