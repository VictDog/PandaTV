//
//  SearchListModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class SearchListModel: NSObject {
    
    var md5: String = ""
    var nickname: String = ""
    var roomid: String = ""
    var hostid: String = ""
    var name: String = ""
    var style: String = ""
//    var class: String = ""
    var classification: String = ""
    var person_num: Int = 0
    var bamboos: Int = 0
    var fans: Int = 0
    var status: Int = 0
    var content: String = ""
    var pictures: [String: Any]?
    var updatetime: String = ""
    var reliable: Int = 0
    var sex: Int = 0
    var province: Int = 0
    var url_footprint: String = ""
    var se: [String: Any]?
    var display_type: Int = 0
    var tag: String = ""
    var tag_switch: Int = 0
    var tag_color: Int = 0
    var style_type: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
