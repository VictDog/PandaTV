//
//  SearchVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class SearchVC: BaseVC {

    let titles = ["正在直播", "未在直播"]
    fileprivate lazy var searchField = UITextField()
    fileprivate lazy var titleView: PageTitleView = {
        [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        // MARK:- 控制器作为EntertainmentTitleView代理
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH+0.5, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH)
        var childVcs = [UIViewController]()
        childVcs.append(IsLivingVC())
        childVcs.append(UnLivingVC())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    lazy var bgview: UIView = {
        let view = UIView()
        view.bounds = self.view.bounds
        view.backgroundColor = BGCOLOR
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavTitleView()
        setupUI()
    }
    
    override func setupUI() {
        contentView = bgview
        view.addSubview(bgview)
        self.resetData()
        super.setupUI()
    }
    
    func setupNavTitleView() {
        let searchView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: kScreenW - 40, height: 44)))
        let bgView = UIView(frame: CGRect(x: 5, y: 7, width: searchView.bounds.size.width - 50 , height: 30))
        bgView.backgroundColor = UIColor(gray: 230)
        searchView.addSubview(bgView)
        
        let searchField = UITextField(frame: CGRect(x: 5, y: 0, width: bgView.bounds.size.width - 5 , height: 30))
        searchField.delegate = self
        self.searchField = searchField
        searchField.clearButtonMode = .whileEditing
        
        searchField.font = UIFont.systemFont(ofSize: 12)
        searchField.placeholder = "搜索房间ID，主播名称"
        bgView.addSubview(searchField)
        
        let searchBtn = UIButton.init(type: .custom)
        searchBtn.setImage(UIImage(named: "searchbutton_nor"), for: .normal)
        searchBtn.frame = CGRect(x: searchField.frame.maxX, y: 7, width: 40, height: 30)
        searchBtn.addTarget(self, action: #selector(SearchVC.searchRoomID), for: .touchUpInside)
        searchView.addSubview(searchBtn)
        self.navigationItem.titleView = searchView
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        titleView.removeFromSuperview()
        pageContentView.removeFromSuperview()
        setupUI()
        return true
    }
}

extension SearchVC {
    // MARK: - 搜索
    func searchRoomID() {
        /// 这里做搜索操作
        if (self.searchField.text != nil) && (self.searchField.text != "") {
            self.loadDataFinished()
            view.addSubview(titleView)
            UserDefaults.standard.set(self.searchField.text!, forKey: "keywords")
            view.addSubview(pageContentView)
        } else {
            
        }
    }
}

//MARK:- PageTitleViewDelegate代理实现
extension SearchVC : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- EntertainmentContentViewDelegate代理实现
extension SearchVC : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
