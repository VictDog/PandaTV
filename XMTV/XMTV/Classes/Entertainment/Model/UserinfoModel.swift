//
//  UserinfoModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class UserinfoModel: NSObject {
    
    var nickName: String = ""
    var rid: Int = 0
    var avatar: String	= ""
    var userName: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
