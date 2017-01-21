//
//  MeVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class MeVC: UITableViewController {

    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "mine_settingIcon2", highlightedImage: "mine_settingIcon2_press", target: self, action: #selector(MeVC.settingClick))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: - 设置tableView
    func setTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = 10
        self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - 点击设置按钮
    func settingClick() {
        let settingVC = UIStoryboard(name: "SettingVC", bundle: nil).instantiateInitialViewController()!
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            print("点我登陆")
        } else if section == 1 {
            print("我要当主播")
        } else if section == 2 {
            print("我的订阅")
        } else if section == 3 {
            print("观看历史")
        } else {
            if row == 0 {
                print("私信")
            } else if row == 1 {
                print("摇一摇")
            } else if row == 2 {
                print("活动中心")
            } else if row == 3 {
                print("开播提醒")
            } else if row == 4 {
                print("意见反馈")
            }

        }
    }
}
