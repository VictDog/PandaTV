//
//  PandaStarShowVM.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class PandaStarShowVM: BaseVM {
    func requestData(finishedCallback : @escaping () -> ()) {
        loadAnchorGroupData(isLiveData: true, URLString: "http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=yzdr&pageno=1&pagenum=20&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore", finishedCallback: finishedCallback)
    }
}
