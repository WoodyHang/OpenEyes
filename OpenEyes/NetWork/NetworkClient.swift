//
//  NetworkClient.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/6.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation
import Alamofire


class NetworkClient: Sendable {
    func sendRequest<T>(_ r: T, success: @escaping (T.Response?) -> Void, failture : @escaping (String) -> Void) where T : Request {
        let url = host + r.path
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        let method = r.method == .POST ? HTTPMethod.post:HTTPMethod.get
        if r.showLoading {
            //加载loading
        }
        Alamofire.request(url, method: method, parameters: r.parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let result = response.result.value, let data = try? JSONSerialization.data(withJSONObject: result, options: JSONSerialization.WritingOptions.init(rawValue: 0)) else {
                    return
                }
                
                let a = T.Response.parse(data: data)
                success(a)
            case .failure(let error):
                failture(error.localizedDescription)
            }
        }

    }
    
    static let `default` = NetworkClient()
    private init() { }

    func send<T>(_ r: T, handler: @escaping (T.Response?) -> Void) where T : Request {
        let url = host + r.path
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]

        let method = r.method == .POST ? HTTPMethod.post:HTTPMethod.get
//        let configuration = URLSessionConfiguration.default
//         configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        let policies: [String: ServerTrustPolicy] = [
//
//            "api.domian.cn": .disableEvaluation
//        ]
//        let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
//        manager.startRequestsImmediately = false
        Alamofire.request(url, method: method, parameters: r.parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let result = response.result.value, let data = try? JSONSerialization.data(withJSONObject: result, options: JSONSerialization.WritingOptions.init(rawValue: 0)) else {
                    return
                }

                let a = T.Response.parse(data: data)
                handler(a)
            case .failure:
                handler(nil)
            }
        }
    }
    var host: String = "";
}


