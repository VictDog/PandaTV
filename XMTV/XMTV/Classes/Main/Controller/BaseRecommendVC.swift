//
//  BaseRecommendVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class BaseRecommendVC: BaseVC {

    var baseVM: BaseVM!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: NormalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension BaseRecommendVC {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
    
    func loadData() {}
}

// MARK: - UICollectionView代理数据源方法
extension BaseRecommendVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.delegate = self
        headerView.total = baseVM.anchorGroups[indexPath.section].total
        headerView.group = baseVM.anchorGroups[indexPath.section].type
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
    }
    //
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
    //}

}

// MARK: - CollectionHeaderViewDelegate
extension BaseRecommendVC: CollectionHeaderViewDelegate {
    func moreLivingList(cataName: String, titleName: String) {
        let moreVC = MoreLivingVC()
        moreVC.cateName = cataName
        moreVC.title = titleName
        navigationController?.pushViewController(moreVC, animated: true)
    }
}
