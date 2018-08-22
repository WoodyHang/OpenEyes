//
//  MaskView.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit

class MaskView: UIView, Maskable {
    var maskId: String = "MaskView"
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    
    public init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        
        Bundle(for: MaskView.classForCoder()).loadNibNamed("MaskView", owner: self, options: nil)
        self.ex_addSubView(contentView)
        
        activityIndicator.startAnimating()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        activityIndicator.stopAnimating()
    }
}
