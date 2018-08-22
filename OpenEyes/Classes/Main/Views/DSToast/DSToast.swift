//
//  DSToast.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/26.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

enum DSToastShowType: Int {
    case top
    case center
    case bottom
}

private let kDefaultForwardAnimationDuration: CFTimeInterval = 0.5
private let kDefaultBackwardAnimationDuration: CFTimeInterval = 0.5
private let kDefaultWaitAnimationDuration: CFTimeInterval = 1.0

private let kDefaultTopMargin: CGFloat = 50.0
private let kDefaultBottomMargin: CGFloat = 50.0
private let kDefalultTextInset: CGFloat = 15.0

class DSToast: UILabel {
    var forwardAnimationDuration: CFTimeInterval = 0.0
    var backwardAnimationDuration: CFTimeInterval = 0.0
    var waitAnimationDuration: CFTimeInterval = 0.0
    var textInsets = UIEdgeInsets()
    var maxWidth: CGFloat = 0.0
    
    var showType: DSToastShowType = .center
    var animationType = DSToastAnimationType.alpha
    
    private var toastAnimation: DSToastAnimation = DSToastAnimation()
    
    
    class func toast(withText text: String) -> DSToast {
        return DSToast.init(text: text, withAnimationType: .alpha)
    }
    
    class func toast(withText text: String, animationType: DSToastAnimationType) -> DSToast {
        return DSToast(text: text, withAnimationType: animationType)
    }
    
    convenience init(text: String) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.sizeToFit()
        self.animationType = .alpha
        self.toastAnimation = DSToastAnimation.toastAnimation()
        self.toastAnimation.delegate = self
    }
    
    convenience init(text: String, withAnimationType animationType: DSToastAnimationType) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.sizeToFit()
        self.animationType = animationType
        self.toastAnimation = DSToastAnimation.toastAnimation()
        self.toastAnimation.delegate = self
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration
        self.waitAnimationDuration = kDefaultWaitAnimationDuration
        
        self.textInsets = UIEdgeInsets(top: kDefalultTextInset, left: kDefalultTextInset + 20, bottom: kDefalultTextInset, right: kDefalultTextInset + 20)
        self.maxWidth = UIScreen.main.bounds.width - 20
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.numberOfLines = 0
        self.textAlignment = .left
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 13.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard let window = self.currentWindow() else {
            fatalError("window不能为空")
        }
        self.showInView(view: window, showType: .center)
    }
    
    func show(withType type: DSToastShowType){
        guard let window = self.currentWindow() else {
            fatalError("window不能为空")
        }
        self.showInView(view: window, showType: type)
    }
    
    func show(inView view: UIView){
        self.addAnimationGroup()
        var point = view.center
        point.y = view.bounds.height - kDefaultBottomMargin
        self.center = point
        view.addSubview(self)
    }
    //TODO:Window
    func currentWindow() -> UIWindow? {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for tempWindow in windows {
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    window = tempWindow
                    break
                }
            }
        }
        return window
    }
    func showInView(view: UIView, showType type: DSToastShowType) {
        self.addAnimationGroup()
        var point = view.center
        switch  type{
        case .top:
            point.y = kDefaultTopMargin
        case .bottom:
            point.y = view.bounds.height - kDefaultBottomMargin
        default:
            break
        }
        
        self.center = point
        view.addSubview(self)
    }
    
    //TODO:Animation
    func addAnimationGroup(){
        self.toastAnimation.forwardAnimationDuration = self.forwardAnimationDuration
        self.toastAnimation.backwardAnimationDuration = self.backwardAnimationDuration
        self.toastAnimation.waitAnimationDuration = self.waitAnimationDuration
        self.layer.add(self.toastAnimation.animationWithType(animationType: self.animationType), forKey: "animation")
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        var frame = self.frame
        let width = self.bounds.width + self.textInsets.left + self.textInsets.right
        frame.size.width = width > self.maxWidth ?self.maxWidth:width
        frame.size.height = self.bounds.height + self.textInsets.top + self.textInsets.bottom
        self.frame = frame
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = bounds
        rect = (self.text! as NSString).boundingRect(with: CGSize.init(width: self.maxWidth - self.textInsets.left - self.textInsets.right, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.font], context: nil)
        return rect
    }
}

extension DSToast: DSToastAnimationDelegate {
    func toastAnimationDidStop(anim: CAAnimation, finished: Bool) {
        if finished {
            self.layer.removeAllAnimations()
            self.removeFromSuperview()
        }
    }
}

extension DSToast: Warnable {
    func show(error: Errorable?) {
        DSToast.toast(withText: error?.message ?? "", animationType: .scale).show(withType: .center)
    }
    
    
}


