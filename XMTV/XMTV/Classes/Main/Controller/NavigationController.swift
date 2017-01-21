//
//  NavigationController.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UINavigationBar.appearance().barTintColor = UIColor.white
        // 设置naviBar背景图片
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(named: "navigationbarBackgroundWhite"), for: UIBarMetrics.default)
        // 设置title的字体
        // UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - 拦截push控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(self.viewControllers.count)
        
        if self.viewControllers.count < 1 {
            viewController.navigationItem.rightBarButtonItem = setRightButton()
            
        } else {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = setBackBarButtonItem()
        }
        super.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: - private method
    func setBackBarButtonItem() -> UIBarButtonItem {
        
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "setting_back"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action: #selector(NavigationController.backClick), for: .touchUpInside)
        return UIBarButtonItem.init(customView: backButton)
    }
    
    /// 设置导航栏右边按钮
    func setRightButton() -> UIBarButtonItem {
        
        let searchItem = UIButton.init(type: .custom)
        searchItem.setImage(UIImage(named: "searchbutton_nor"), for: .normal)
        searchItem.sizeToFit()
        searchItem.frame.size = CGSize(width: 30, height: 30)
        searchItem.contentHorizontalAlignment = .right
        searchItem.addTarget(self, action: #selector(NavigationController.searchClick), for: .touchUpInside)
        return UIBarButtonItem.init(customView: searchItem)
    }
    
    /// 点击右边的搜索
    func searchClick() {
        let searchvc = SearchVC()
        self.pushViewController(searchvc, animated: true)
    }
    
    /// 返回
    func backClick() {
        self.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
