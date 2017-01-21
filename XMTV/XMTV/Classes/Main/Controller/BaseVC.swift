//
//  BaseVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    var contentView : UIView?
    fileprivate lazy var loadView: UIView = { [unowned self] in
        let view = UIView()
        view.frame = CGRect(origin: .zero, size: CGSize(width: kScreenW, height: kScreenH-kNavigationBarH-2 * kTabBarH))
        
        let imageView = UIImageView(image: UIImage(named: "0tai_icon2-1"))
        imageView.center = view.center
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 13)
        title.textColor = UIColor.darkGray
        title.text = "在这里，你会找到最有趣的直播。"
        title.textAlignment = .center
        title.center = CGPoint(x: imageView.center.x, y: imageView.frame.maxY+10)
        title.bounds.size = CGSize(width: kScreenW, height: 20)
        
        view.addSubview(imageView)
        view.addSubview(title)
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseVC {
    func setupUI() {
        contentView?.isHidden = true
        view.addSubview(loadView)
        view.backgroundColor = BGCOLOR
    }
    
    func loadDataFinished() {
        loadView.isHidden = true
        contentView?.isHidden = false
    }
    
    func resetData() {
        loadView.isHidden = false
        contentView?.isHidden = true
    }
}
