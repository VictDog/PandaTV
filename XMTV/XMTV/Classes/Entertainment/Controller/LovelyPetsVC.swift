//
//  LovelyPetsVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class LovelyPetsVC: BaseEntertainmentVC {

    fileprivate lazy var lovelyVM: LovelyPetsVM = LovelyPetsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData() {
        baseVM = self.lovelyVM
        lovelyVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }

}
