//
//  ViewController.swift
//  OpenEyes
//
//  Created by Woodyhang on 2018/6/6.
//  Copyright © 2018年 航仔. All rights reserved.
//

import UIKit
import Alamofire
struct WebJSON:Codable {
    var name:String
    var node:String
    var version: Int?
}

struct WeatherResponse: Codable {
    
    var location: String?
    var threeDayForecast: String?
}

struct weatherError: JSONErrorable {
    var rootPath: String? = "data"
    var successCodes: [String] = ["200"]
    
    var code: String?
    var message: String?
    enum CodingKeys : String, CodingKey {
        case code = "location"
        case message = "lacation"
    }
}
class ViewController: UIViewController, Requestable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        //request(WeatherForm())
        
//        NetworkClient.default.send(UserRequest()) { (user) in
//            
//        }
//        //
//        //        request(WeatherForm()).load(load: LoadType.default(container: UIButton()))
//        request(WeatherForm()).JSONToModel { (result: WeatherResponse) in
//            
//        }
        
//        request(WeatherForm())
//            .load(load: MyHUD(container: self.view, message: "数据请求中"))
//            .JSONToModel { (result: WeatherResponse) in
//              print(result)
//        }
        request(WeatherForm())
            .load(load: LoadType.default(container: self.view))
            .JSONToModel { (result: WeatherResponse) in
                print(result)
            }.warn(error: weatherError(), warn: DSToast())
  
        //print(UIApplication.shared.keyWindow)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print(UIApplication.shared.keyWindow)
//              DSToast(text: "1俄舒服好舒服 i 官方 i 时光", withAnimationType: .scale
//                ).show(withType: .bottom)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

