//
//  NetworkTool.swift
//  XMTV
//
//  Created by Mac on 2017/1/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTool {
    class func request(type: MethodType, urlString: String, paramters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
        // 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 发送网络请求
        Alamofire.request(urlString, method: method, parameters: paramters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            // 回调
            finishedCallback(result as AnyObject)
        }
    }
}
