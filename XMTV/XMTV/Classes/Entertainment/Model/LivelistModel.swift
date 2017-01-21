//
//  LivelistModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class LivelistModel: NSObject {
    
    var id: String =	""
    var ver: String	= ""
    var createtime:	String	= ""
    var updatetime:	String	= ""
    var name: String	= ""
    var hostid: String	= ""
    var person_num:	Int = 0
    var announcement: String = ""
    
    var classification: [String: Any]?
    var pictures: [String: Any]?
    var userinfo: [String: Any]?
    
    var status: Int = 0
    var start_time:	String = ""
    var end_time: String = ""
    var duration: String = ""
    var schedule: Int = 0
    var remind_switch: Int = 0
    var remind_content: String = ""
    var level: Int = 0
    var stream_status: Int = 0
    var classify_switch: Int = 0
    var reliable: Int = 0
    var banned_reason: Int = 0
    var unlock_time: Int = 0
    var speak_interval: Int = 0
    var person_num_thres: String = ""
    var reduce_ratio: String = ""
    var person_switch: String = ""
    var watermark_switch: Int = 0
    var watermark_loc: Int = 0
    var account_status: Int = 0
    var person_src: String = ""
    var display_type: Int = 0
    var tag: String = ""
    var tag_switch: Int = 0
    var tag_color: Int = 0
    var rcmd_ratio: Int = 0
    var show_pos: Int = 0
    var rtype_usable: Int = 0
    var room_type: Int = 0
    var rtype_value: Int = 0
    var style_type: Int = 0
    var cdn_rate: Int = 0
    var room_key: String = ""
    var fans: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
