//
//  Response.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/19.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation
import Alamofire

//TODO:加载等待框
extension DataRequest {
    
    @discardableResult
    func load(load: BaseLoadable = LoadType.none) -> Self {
        load.begin()
        return response(completionHandler: { (response) in
            load.end()
        })
    }
}

extension DataRequest {
    @discardableResult
    func warn<T: JSONErrorable>(
        error: T,
        warn: Warnable,
        completionHandler: ((JSONErrorable) -> Void)? = nil
        ) -> Self {
        return response(completionHandler: { (response: DefaultDataResponse) in
            if let err = response.error { // Network error
                warn.show(error: err.localizedDescription)
            }
        }).responseObject(keyPath:error.rootPath, completionHandler: { (response: DataResponse<T>) in
            if let err = response.error { // Serialize error
                warn.show(error: err.localizedDescription)
            } else {
                if let err = response.result.value {
                    if let code = err.code {
                        if true == error.successCodes.contains(code) { // User handled error code
                            if completionHandler != nil {
                                completionHandler?(err)
                            }
                        } else {
                            warn.show(error: err.message)
                        }
                    } else {
                        print("Parse error code failed")
                    }
                }
            }
        })
    }
    
    @discardableResult
    func inform<T: JSONErrorable>(error: T, inform: Informable) -> Self {
        return responseObject(keyPath: error.rootPath) { (response: DataResponse<T>) in
            if let err = response.result.value {
                if let code = err.code {
                    if true == error.successCodes.contains(code) {
                        inform.show()
                    }
                }
            }
        }
    }
}

extension DataRequest {
    
    @discardableResult
    func JSONToModel<T:Codable>(completionHandler: @escaping (_ result: T) -> Void) -> Self {
        return responseObject(keyPath: "data") { (response: DataResponse<T>) in
            if let value = response.result.value {
                completionHandler(value)
            }
        }
    }
        
}

