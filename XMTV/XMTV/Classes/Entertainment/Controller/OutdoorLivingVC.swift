//
//  OutdoorLivingVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class OutdoorLivingVC: BaseEntertainmentVC {

    fileprivate lazy var outdoorVM: OutdoorLivingVM = OutdoorLivingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData() {
        baseVM = self.outdoorVM
        outdoorVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}


