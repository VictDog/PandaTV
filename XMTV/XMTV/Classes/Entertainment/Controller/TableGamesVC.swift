//
//  TableGamesVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class TableGamesVC: BaseEntertainmentVC {

    fileprivate lazy var tableGamesVM: TableGamesVM = TableGamesVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData() {
        baseVM = self.tableGamesVM
        tableGamesVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
