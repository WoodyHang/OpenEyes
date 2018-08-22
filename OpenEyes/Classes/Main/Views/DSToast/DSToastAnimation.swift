//
//  DSToastAnimation.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/25.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

protocol DSToastAnimationDelegate: class {
    func toastAnimationDidStop(anim: CAAnimation, finished: Bool)
}

private let kScaleKeyPath = "transform.scale"
private let kOpacityKeyPath = "opacity"
enum DSToastAnimationType: Int {
    case alpha = 0 //default
    case scale = 1
    case positionLeftToRight = 2
}
class DSToastAnimation: NSObject {

    var forwardAnimationDuration: CFTimeInterval = 0.0
    var backwardAnimationDuration: CFTimeInterval = 0.0
    var waitAnimationDuration: CFTimeInterval = 0.0
    
    weak var delegate: DSToastAnimationDelegate?
    
    class func toastAnimation() -> DSToastAnimation {
        return DSToastAnimation()
    }
    
    func animationWithType(animationType: DSToastAnimationType) -> CAAnimation {
        var forwardAnimation = CABasicAnimation()
        var backwardAnimation = CABasicAnimation()
        
        switch animationType {
        case .alpha:
            forwardAnimation = CABasicAnimation(keyPath: kOpacityKeyPath)
            backwardAnimation = CABasicAnimation(keyPath: kOpacityKeyPath)
            
            forwardAnimation.fromValue = 0.0
            forwardAnimation.toValue = 1.0
            backwardAnimation.fromValue = 1.0
            backwardAnimation.toValue = 0.0
        case .scale:
            forwardAnimation = CABasicAnimation(keyPath: kScaleKeyPath)
            backwardAnimation = CABasicAnimation(keyPath: kScaleKeyPath)
            
            forwardAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.7, 0.6, 0.85)
            backwardAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.15, 0.5, -0.7)
            
            forwardAnimation.fromValue = 0.0
            forwardAnimation.toValue = 1.0
            backwardAnimation.fromValue = 1.0
            backwardAnimation.toValue = 0.0
        case .positionLeftToRight:
            forwardAnimation = CABasicAnimation(keyPath: "position.x")
            backwardAnimation = CABasicAnimation(keyPath: "position.x")
            
            forwardAnimation.fromValue = -UIScreen.main.bounds.width
            forwardAnimation.toValue = UIScreen.main.bounds.width / 2
            backwardAnimation.fromValue = UIScreen.main.bounds.width / 2
            backwardAnimation.toValue = UIScreen.main.bounds.width * 2
        }
        
        forwardAnimation.duration = self.forwardAnimationDuration
        backwardAnimation.duration = self.backwardAnimationDuration
        backwardAnimation.beginTime = forwardAnimation.duration + self.waitAnimationDuration
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [forwardAnimation, backwardAnimation]
        animationGroup.duration = self.forwardAnimationDuration + self.waitAnimationDuration + self.backwardAnimationDuration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.delegate = self
        animationGroup.fillMode = kCAFillModeForwards
        return animationGroup
        
    }
}

extension DSToastAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.delegate?.toastAnimationDidStop(anim: anim, finished: flag)
    }
}
