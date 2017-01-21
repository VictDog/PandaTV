//
//  GameModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class GameModel: NSObject, NSCoding {

    var cname: String = ""
    var ename: String = ""
    var img: String	= ""
    var ext: String	= ""
    var status: Int?
    var cdn_rate: Int?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder) {
        aCoder.encode(cname, forKey:"cname")
        aCoder.encode(ename, forKey:"ename")
        aCoder.encode(img, forKey:"img")
        aCoder.encode(ext, forKey:"ext")
        aCoder.encode(status, forKey:"status")
        aCoder.encode(cdn_rate, forKey:"cdn_rate")
    }
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder) {
        super.init()
        cname = (aDecoder.decodeObject(forKey:"cname")as? String)!
        ename = (aDecoder.decodeObject(forKey:"ename")as? String)!
        img = (aDecoder.decodeObject(forKey:"img")as? String)!
        ext = (aDecoder.decodeObject(forKey:"ext")as? String)!
        status = aDecoder.decodeObject(forKey:"status")as? Int
        cdn_rate = aDecoder.decodeObject(forKey:"cdn_rate")as? Int
    }
    
    override init() {
        super.init()
    }
}
