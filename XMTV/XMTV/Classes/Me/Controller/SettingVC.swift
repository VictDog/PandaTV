//
//  SettingVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    fileprivate func setupUI() {
        title = "设置"
        self.tableView.separatorStyle = .none
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = 10
        self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("扫一扫")
            break
        case 1:
            print("硬件解码")
            break
        case 2:
            print("清除缓存")
            break
        case 3:
            print("关于我们")
            break
            
        default:
            break
        }
    }
    
}
