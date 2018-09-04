//
//  UIImageExtension.swift
//  OpenEyes
//
//  Created by hysea on 2018/9/4.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation

extension UIImage {
    public class func image(WithColor color: UIColor) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.setFillColor(color.cgColor);
        ctx!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
