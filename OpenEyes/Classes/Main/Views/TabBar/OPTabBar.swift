//
//  OPTabBar.swift
//  OpenEyes
//
//  Created by hysea on 2018/9/3.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

private let Margin: CGFloat = 20
class OPTabBar: UITabBar {
    private lazy var plusBtn: UIButton = {
        let plusBtn = UIButton(type: .custom)
        plusBtn.setBackgroundImage(UIImage(named: "ic_tabbar_addBtn"), for: .normal)
        plusBtn.setBackgroundImage(UIImage(named: "ic_tabbar_addBtn"), for: .highlighted)
        plusBtn.addTarget(self, action: #selector(plusBtnDidClick), for: .touchUpInside)
        return plusBtn
    }()
    
    private lazy var line: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.red
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //self.shadowImage = UIImage.image(WithColor: UIColor.clear)
        
//        self.backgroundImage = UIImage()
//        self.shadowImage = UIImage()
        self.addSubview(self.plusBtn)
        //self.addSubview(line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.plusBtn.centerX = self.centerX
        self.plusBtn.centerY = self.height * 0.5 - 2 * Margin
        self.plusBtn.size = CGSize(width: 80, height: 80)
        
//        self.line = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 1))
//        self.insertSubview(line, at: 1)
        var btnIndex = 0
        let tabBarButtons = self.subviews.filter { return $0.isKind(of: NSClassFromString("UITabBarButton")!) }
        for btn in tabBarButtons {
            btn.width = self.width / 5
            btn.left = btn.width * CGFloat(btnIndex)
            btn.top = 5.0
            btnIndex += 1
            if btnIndex == 2 {
                btnIndex += 1
            }
        }
        
 
        self.bringSubview(toFront: self.plusBtn)
    }
}

//MARK: --按钮点击事件
extension OPTabBar {
    @objc private func plusBtnDidClick() {
   
    }
}

//MARK: --HitTest
extension OPTabBar {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
         //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的
        if !self.isHidden {
            //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
            let newPoint = self.convert(point, to: self.plusBtn)
            //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
            if self.plusBtn.point(inside: newPoint, with: event) {
                return self.plusBtn
            }else {
                return super.hitTest(point, with: event)
            }
        }else {
            //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
            return super.hitTest(point, with: event)
        }
    }
    
}

