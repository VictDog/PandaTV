//
//  BannersModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class BannersModel: NSObject {
    
    var roomid: String = ""
    var name: String = ""
    var display_type: Int = 0
    var title: String = ""
    var bigimg: String = ""
    var smallimg: String = ""
    var style_type: Int = 0
    var type: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
