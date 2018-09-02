//
//  OPTabBarViewController.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/9/2.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

enum HomeTab: Int {
    case home = 0
    case attention = 1
    case notification = 2
    case me = 3
}
class OPTabBarViewController: UITabBarController {

    struct Const {
//        static func getTitle(_ tab: HomeTab) -> String {
//            switch tab {
//            case .home:
//                return ""
//            case .account:
//                return AccountManager.get().getAccount().name
//            case .more:
//                return "更多"
//            }
//        }
        
//        static func getTabName(_ tab: HomeTab) -> String {
//            switch tab {
//            case .home:
//                return "HomeTab"
//            case .account:
//                return "AccountTab"
//            case .more:
//                return "MoreTab"
//            }
//        }
        
        static func getUnselectedImage(_ tab: HomeTab) -> UIImage? {
            switch tab {
            case .home:
                return UIImage(named: "ic_tab_home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .attention:
                return UIImage(named: "ic_tab_follow")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .notification:
                return UIImage(named: "ic_tab_noti")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .me:
                return UIImage(named: "ic_tab_4")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            }
        }
        
        static func getSelectedImage(_ tab: HomeTab) -> UIImage? {
            switch tab {
            case .home:
                return UIImage(named: "ic_tab_home_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .attention:
                return UIImage(named: "ic_tab_follow_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .notification:
                return UIImage(named: "ic_tab_noti_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            case .me:
                return UIImage(named: "ic_tab_4_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }

    private func addChildViewControllers() {
        setupOneChildViewController(image: Const.getUnselectedImage(.home)!, selectedImage: Const.getSelectedImage(.home)!, controller: ViewController())

        setupOneChildViewController(image: Const.getUnselectedImage(.attention)!, selectedImage: Const.getSelectedImage(.attention)!, controller: ViewController())
        setupOneChildViewController(image: Const.getUnselectedImage(.notification)!, selectedImage: Const.getSelectedImage(.notification)!, controller:ViewController())
        setupOneChildViewController(image: Const.getUnselectedImage(.me)!, selectedImage: Const.getSelectedImage(.me)!, controller: ViewController())
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], for: UIControlState.selected)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], for: UIControlState())
//        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    // MARK: - 添加一个子视图的控制器
    private func setupOneChildViewController(_ title: String? = "", image: UIImage, selectedImage: UIImage, controller: UIViewController) {
        controller.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 100)
        //self.viewControllers?.append(UINavigationController(rootViewController: controller))
        self.addChildViewController(controller)
    }
}

//extension OPTabBarViewController: UITabBarDelegate {
//
//}
