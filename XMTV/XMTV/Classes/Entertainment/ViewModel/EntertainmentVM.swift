//
//  EntertainmentVM.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class EntertainmentVM: NSObject {
    
    lazy var livelistModels : [LivelistModel] = [LivelistModel]()
    
//    cate=hwzb&pageno=2&pagenum=10&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore
//    func requestLivelistData(_ finishCallback : @escaping () -> ()){
//        HttpTools.requestData(.get, URLString: "http://api.m.panda.tv/ajax_get_live_list_by_cate", parameters: ["version" : "2.401"]) { (result) in
//            guard let dict = result as? [String : Any] else { return }
//            guard let arr = dict["data"] as? [[String : Any]] else { return }
//            for dict in arr {
//                self.livelistModels.append(LivelistModel(dict: dict))
//            }
//            finishCallback()
//        }
//    }
}
