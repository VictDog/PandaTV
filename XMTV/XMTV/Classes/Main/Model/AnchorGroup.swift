//
//  AnchorGroup.swift
//  XMTV
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    lazy var anchors: [LivelistModel] = [LivelistModel]()
    var type: TypeModel?
    var total: Int = 0
    var items: [[String: Any]]? {
        didSet {
            guard let items1 = items else { return }
            for dict in items1 {
                anchors.append(LivelistModel(dict: dict))
            }
        }
    }
    
    override init() {}
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
