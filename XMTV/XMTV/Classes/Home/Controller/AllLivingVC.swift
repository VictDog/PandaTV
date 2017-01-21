//
//  AllLivingVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class AllLivingVC: BaseSearchVC {

    fileprivate lazy var allLivingVM: AllLivingVM = AllLivingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK:- 发送网络请求
extension AllLivingVC {
    override func loadData() {
        baseVM = self.allLivingVM
        allLivingVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
