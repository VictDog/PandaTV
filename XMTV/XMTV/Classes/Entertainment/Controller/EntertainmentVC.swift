//
//  EntertainmentVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class EntertainmentVC: UIViewController {

    let titles = ["熊猫星秀","户外直播","音乐","萌宠乐园","桌游"]
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        // MARK:- 控制器作为EntertainmentTitleView代理
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH+0.5, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(PandaStarShowVC())
        childVcs.append(OutdoorLivingVC())
        childVcs.append(MusicVC())
        childVcs.append(LovelyPetsVC())
        childVcs.append(TableGamesVC())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- setupUI
extension EntertainmentVC {
    fileprivate func setupUI() {
        //不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

//MARK:- PageTitleViewDelegate代理实现
extension EntertainmentVC : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- EntertainmentContentViewDelegate代理实现
extension EntertainmentVC : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

