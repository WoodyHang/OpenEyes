//
//  NetworkProtocol.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/6.
//  Copyright © 2018年 航仔. All rights reserved.
//

import Foundation
import Alamofire

typealias StrongCodable = Codable & NetworkDecodable
enum RequestMethod: String {
    case GET
    case POST
}

protocol Request {
    var path: String { get }
    var method: RequestMethod { get }
    var parameter: [String: Any] { get }
    var showLoading: Bool { get }
    
    associatedtype Response: StrongCodable
    
}

protocol NetworkDecodable {}

extension NetworkDecodable where Self: Codable{
    //使用官方的字典转模型
    static func parse(data: Data) -> Self?{
        let jsonDecoder = JSONDecoder()
        let jsonModel = try? jsonDecoder.decode(self, from: data)
        return jsonModel
    }
}

protocol Sendable {
    func sendRequest<T: Request>(_ r: T, success:@escaping (T.Response?) -> Void, failture failtureClourse: @escaping (_ errorMsg: String) -> Void)
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?) -> Void)
    var host: String { get }
}

public struct User: NetworkDecodable,Codable {

    let name:String
    let message:String
}

struct aa:NetworkDecodable,Codable {
    let n12ame:String
    let me23ssage:String

}


struct UserRequest1:Request {
    
    typealias Response = aa
    
    var showLoading: Bool = true
    
    var path: String {
        return ""
    }
    
    var method: RequestMethod = .GET
    
    var parameter: [String : Any] = [:]
    
    
    
    
}

struct UserRequest:Request {
    var showLoading: Bool = true

    var path: String {
        return ""
    }

    var method: RequestMethod = .GET

    var parameter: [String : Any] = [:]

    typealias Response = User



}


