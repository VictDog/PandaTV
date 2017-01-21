//
//  GameVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kGameItemMargin : CGFloat = 4
private let kItemW = (kScreenW - kGameItemMargin * 4) / 3
private let kItemH = kScreenW / 2
private let kGameCellID = "kGameCellID"

class GameVC: UIViewController {

    fileprivate lazy var gameArray = [GameModel]()
    fileprivate lazy var gameVM: GameVM = GameVM()
    /// 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = kGameItemMargin
        layout.minimumInteritemSpacing = kGameItemMargin
        layout.sectionInset = UIEdgeInsets(top: kGameItemMargin, left: kGameItemMargin, bottom: kGameItemMargin, right: kGameItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = BGCOLOR
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        return collectionView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }
}

extension GameVC {
    // MARK: - 设置UI内容
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
    // MARK: - 发送网络请求
    fileprivate func requestData () {
        gameVM.loadGameData {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - 遵守协议
extension GameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.backgroundColor = UIColor.white
        cell.gameModel = gameVM.gameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击cell 跳转控制器
        let moreVC = MoreLivingVC()
        let model = gameVM.gameArray[indexPath.item]
        moreVC.cateName = model.ename
        moreVC.title = model.cname
        self.navigationController?.pushViewController(moreVC, animated: true)
    }
    
}
