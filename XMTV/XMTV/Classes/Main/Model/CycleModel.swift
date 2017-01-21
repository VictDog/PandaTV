//
//  CycleModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title : String = ""
    var smallimg : String = ""
    var bigimg : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
