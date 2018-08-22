//
//  Message.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation

protocol Messageable {
    func messageContainer() -> Containable?
}

extension Messageable {
    func messageContainer() -> Containable? {
        return nil
    }
}

extension Informable {
    func message() -> String {
        return "Successfully"
    }
}

protocol Informable: Messageable {
    func show()
    
    func message() -> String
}

protocol Warnable: Messageable {
    func show(error: Errorable?)
}
