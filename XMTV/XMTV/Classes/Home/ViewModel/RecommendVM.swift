//
//  RecommendVM.swift
//  XMTV
//
//  Created by Mac on 2017/1/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class RecommendVM: BaseVM {
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var allGroup: AnchorGroup = AnchorGroup()
    let params = ["pagenum":"4", "hotroom": "1", "__version": "1.1.7.1305", "__plat": "ios", "__channel": "appstore"]
}

extension RecommendVM {
    //http://api.m.panda.tv/ajax_get_live_list_by_multicate?pagenum=4&hotroom=1&__version=1.1.7.1305&__plat=ios&__channel=appstore
    func requestData(finishedCallback : @escaping () -> ()) {
        loadAnchorGroupData(isLiveData: false, URLString: "http://api.m.panda.tv/ajax_get_live_list_by_multicate", parameters:params, finishedCallback: finishedCallback)
    }
    // MARK: - 请求轮播数据
    func requestCycleData(_ finishCallback : @escaping () -> ()){
        let parameters = ["__version": "1.1.7.1305", "__plat": "ios", "__channel": "appstore"]
        NetworkTool.request(type: .GET, urlString: "http://api.m.panda.tv/ajax_rmd_ads_get", paramters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            for dict in arr {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            print("cycleModels - ",self.cycleModels)
            finishCallback()
        }
    }
}
