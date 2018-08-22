//
//  Error.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation

protocol Errorable {
    var rootPath: String? { get }
    
    var successCodes: [String] { get }
    
    var code: String? { get }
    
    var message: String? { get }
}

extension Errorable {
    var successCodes: [String] {
        return []
    }
    
    var rootPath: String? {
        return nil
    }
    
    var code: String? {
        return nil
    }
    
    var message: String? {
        return nil
    }
}

protocol JSONErrorable: Errorable, Codable {
    
}
