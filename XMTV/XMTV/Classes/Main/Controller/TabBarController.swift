//
//  TabBarController.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override class func initialize() {
        var attrs = [String: NSObject]()
        attrs[NSForegroundColorAttributeName] = UIColor(r: 87, g: 206, b: 138)
        // 设置tabBar字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for:.selected)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 49))
        backView.backgroundColor = UIColor.white
        tabBar.insertSubview(backView, at: 0)
        tabBar.isOpaque = true
    }

    // MARK: - private method
    /// 添加所有子控制器
    func addChildViewControllers() {
        
        setupOneChildViewController("首页", image: "menu_homepage_nor", selectedImage: "menu_homepage_sel", controller: HomeVC.init())
        setupOneChildViewController("游戏", image: "menu_youxi_nor", selectedImage: "menu_youxi_sel", controller: GameVC.init())
        setupOneChildViewController("娱乐", image: "menu_yule_nor", selectedImage: "menu_yule_sel", controller: EntertainmentVC.init())
        setupOneChildViewController("小葱秀", image: "menu_goddess_nor", selectedImage: "menu_goddess_sel", controller: SmallShowVC.init())
        setupOneChildViewController("我的", image: "menu_mine_nor", selectedImage: "menu_mine_sel", controller: UIStoryboard(name: "Me", bundle: nil).instantiateInitialViewController()!)
        
    }
    
    /// 添加一个子控制器
    fileprivate func setupOneChildViewController(_ title: String, image: String, selectedImage: String, controller: UIViewController) {
        
        controller.tabBarItem.title = title
        controller.title = title
        controller.view.backgroundColor = BGCOLOR
        controller.tabBarItem.image = UIImage(named: image)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        let naviController = NavigationController.init(rootViewController: controller)
        addChildViewController(naviController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
