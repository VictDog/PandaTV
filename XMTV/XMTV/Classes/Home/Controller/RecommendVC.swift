//
//  RecommendVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 2 / 5

class RecommendVC: BaseRecommendVC {
    
    fileprivate lazy var recommendVM : RecommendVM = RecommendVM()
    fileprivate lazy var cycleView : BannerCycleView = {
        let cycleView = BannerCycleView.bannerCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)//指定大小
        return cycleView
    }()
    
}

extension RecommendVC {
    override func setupUI(){
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 网络请求
extension RecommendVC {
    override func loadData(){
        baseVM = recommendVM
        //闭包对VC有强引用  VC对recommendVM有强引用 recommendVM没有对闭包有强引用 =>没有形成循环引用
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        self.loadDataFinished()
    }
}

extension RecommendVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}
