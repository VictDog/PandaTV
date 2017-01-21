//
//  MusicVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class MusicVC: BaseEntertainmentVC {

    fileprivate lazy var musicVM: MusicVM = MusicVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData() {
        baseVM = self.musicVM
        musicVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
