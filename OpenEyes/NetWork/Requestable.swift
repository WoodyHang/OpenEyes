//
//  Requestable.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/8.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable: class {}

extension Requestable {
    @discardableResult
    func request<T:RequestFormable>(_ form: T) -> DataRequest {
        return Alamofire.request(
            form.url,
            method: form.method,
            parameters: form.parameters(),
            encoding: form.encoding(),
            headers: form.headers()
        )
    }
}
