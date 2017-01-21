//
//  BaseAllLivingVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class BaseAllLivingVC: BaseVC {

    var baseVM: BaseVM!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: NormalCellID)
        
        return collectionView
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

// MARK: -
extension BaseAllLivingVC {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}

// MARK: - loadData
extension BaseAllLivingVC {
    func loadData() {}
}

// MARK: - UICollectionView代理数据源方法
extension BaseAllLivingVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM.anchorGroups.count > 0 {
            return baseVM.anchorGroups[section].anchors.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
}

extension BaseAllLivingVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //        anchor.isVertical == 0 ? pushNormalRoomVc(anchor) : presentShowRoomVc(anchor)
    }
    
    //    private func presentShowRoomVc(_ anchor : AnchorModel) {
    //        let showVc = ShowRoomVC()
    //        showVc.anchor = anchor
    //        present(showVc, animated: true, completion: nil)
    //    }
    //
    //    private func pushNormalRoomVc(_ anchor : AnchorModel) {
    //        let normalVc = NormalRoomVC()
    //        normalVc.anchor = anchor
    //        navigationController?.pushViewController(normalVc, animated: true)
    //    }
}
