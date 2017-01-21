//
//  MoreLivingVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class MoreLivingVC: BaseEntertainmentVC {

    var cateName: String = ""
    fileprivate lazy var moreLivingVM: MoreLivingVM = MoreLivingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- 发送网络请求
    override func loadData() {
        baseVM = self.moreLivingVM
        moreLivingVM.cate = cateName
        moreLivingVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
