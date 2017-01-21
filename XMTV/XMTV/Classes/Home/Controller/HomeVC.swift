//
//  HomeVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeVC: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var pageMenuView: PageMenuView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let menuView = PageMenuView(frame: frame)
        menuView.delegate = self
        return menuView
    }()
    
    fileprivate lazy var vc: UIViewController = {
        let vc = UIViewController.init()
        vc.view.backgroundColor = UIColor.randomColor()
        return vc
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        
        let savedCount = UserDefaults.standard.object(forKey: HOME_CHILDVCS) as? Int
        
        if savedCount != nil {
            childVcs.append(RecommendVC())
            childVcs.append(AllLivingVC())
            if savedCount! > 1 {
                for _ in 0..<(savedCount! - 2) {
                    childVcs.append((self?.vc)!)
                }
            }
            UserDefaults.standard.set(childVcs.count, forKey: HOME_CHILDVCS)
            print("childvcs-",childVcs)
        } else {
            childVcs.append(RecommendVC())
            childVcs.append(AllLivingVC())
            UserDefaults.standard.set(childVcs.count, forKey: DEFAULT_CHILDVCS)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateChannel(notification:)), name: NotifyUpdateCategory, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotifyUpdateCategory, object: nil)
    }
}

extension HomeVC {
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.titleView = UIImageView(image: UIImage(named: "title_image"))
        view.addSubview(pageMenuView)
        view.addSubview(pageContentView)
    }
    
}

//MARK:- PageTitleViewDelegate代理实现
extension HomeVC : PageMenuViewDelegate{
    func pageMenuView(_ titleView: PageMenuView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- PageContentViewDelegate代理实现
extension HomeVC : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageMenuView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:- updateChannel
extension HomeVC {
    func updateChannel(notification: NSNotification) {
        let dict = notification.userInfo
        var childvcs = [UIViewController]()
        if dict != nil {
            guard let channels = dict![KSelectedChannel] else { return }
        
            if (channels as! [GameModel]).count > 0 {
                for _ in 0..<((channels as! [GameModel]).count) {
                    childvcs.append(self.vc)
                }
                pageContentView.reloadChildVcs(newChildVcs: childvcs)
            } else {
                pageContentView.setDefaultChildVcs()
            }
        }
    }
}


