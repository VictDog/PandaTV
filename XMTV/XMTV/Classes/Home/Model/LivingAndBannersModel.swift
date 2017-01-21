//
//  LivingAndBannersModel.swift
//  XMTV
//
//  Created by Mac on 2017/1/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class LivingAndBannersModel: NSObject {
    
    lazy var anchors: [LivelistModel] = [LivelistModel]()
    lazy var bannerAds: [BannersModel] = [BannersModel]()
    var total: Int = 0
    var items: [[String: Any]]? {
        didSet {
            guard let items1 = items else { return }
            for dict in items1 {
                anchors.append(LivelistModel(dict: dict))
            }
        }
    }
    
    var banners: [[String: Any]]? {
        didSet {
            guard let banner = banners else { return }
            for dict in banner {
                bannerAds.append(BannersModel(dict: dict))
            }
        }
    }
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
