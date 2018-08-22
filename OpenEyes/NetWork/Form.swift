//
//  Form.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/7.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation
import Alamofire

protocol Formable {
    var url: String { get }
    
    var method: Alamofire.HTTPMethod { get }
    
    func headers() -> [String: String]

}

protocol UploadFormable: Formable {
    
}

extension Formable {
    func headers() -> [String: String] {
        return ["Accept": "application/json"]
    }
}

extension Formable where Self: UploadFormable {
    func headers() -> [String: String] {
        return ["accessToken": "xxx", "fileName": "xxx"]
    }
}
protocol RequestFormable: Formable {
    
    func encoding() -> ParameterEncoding
    
    func parameters() -> [String: Any]
    
}

extension RequestFormable {
    func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    func parameters() -> [String: Any] {
        return [ : ]
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
}



struct WeatherForm: RequestFormable {
    var city = "shanghai"
    
    func parameters() -> [String: Any] {
        return ["city": city]
    }
    
    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/"
        + "2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
}

