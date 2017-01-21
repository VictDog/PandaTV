//
//  PageContentView.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

//MARK:- 定义代理1
protocol PageContentViewDelegate :class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat,sourceIndex :Int , targetIndex :Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    // 默认控子制器
    let defaultVcsCount = UserDefaults.standard.object(forKey: DEFAULT_CHILDVCS) as! Int
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var childVcs :[UIViewController]
    //需要改成弱引用，否则有循环引用
    fileprivate weak var parentVc : UIViewController?
    //MARK:- 定义代理2
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout =  UICollectionViewFlowLayout()
        //布局属性 大小 滚动方向  间距
        layout.itemSize = (self?.bounds.size)!//使用[weak self] in 后: self.bounds.size => (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    init(frame: CGRect,childVcs : [UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc //可选类型赋值给可选类型
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    fileprivate func setupUI(){
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource数据源协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK:- 遵守UICollectionViewDelegate代理
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //是点击传导过来的，则不处理
        if isForbidScrollDelegate { return }
        
        //滚动处理
        var progress : CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex =  Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            //完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                sourceIndex = targetIndex
            }
            //            print(">right>progress[\(progress)] sourceIndex[\(sourceIndex)] targetIndex[\(targetIndex)]")
        }
        //MARK:- 定义代理3
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: - homevc作为Pageview的代理，再由homevc调用到这里
extension PageContentView {
    func setCurrentIndex(currentIndex : Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat( currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}

//MARK: - 公共方法，当添加或移除分类后，需要同步刷新PageContentView
extension PageContentView {
    //MARK: - 刷新子控制器
    public func reloadChildVcs(newChildVcs: [UIViewController]) {
        print("newChildVcs-", newChildVcs)
        if self.childVcs.count < (defaultVcsCount + newChildVcs.count) {
            for childVc in newChildVcs {
                self.childVcs.append(childVc)
                parentVc?.addChildViewController(childVc)
            }
        } else {
            let count = self.childVcs.count - (defaultVcsCount + newChildVcs.count)
            updateChildVcs(count: count)
        }
        UserDefaults.standard.set(self.childVcs.count, forKey: HOME_CHILDVCS)
        collectionView.reloadData()
    }
    
    //MARK: - 没有添加频道或者移除了所有的频道，回到默认状态
    public func setDefaultChildVcs() {
        // 移除 "精彩推荐"和"全部直播"两个频道之外的所有频道控制器
        // 当前子控制器个数 - 默认子控制个数 = 需要移除控制器的个数
        let counts = self.childVcs.count - defaultVcsCount
        updateChildVcs(count: counts)
        UserDefaults.standard.set(self.childVcs.count, forKey: HOME_CHILDVCS)
        collectionView.reloadData()
    }
    //MARK: - 更新控制器
    func updateChildVcs(count: Int) {
        var i = 0
        let lastChildVcsCount = UserDefaults.standard.object(forKey: HOME_CHILDVCS) as! Int
        
        print("removecount-",count)
        for _ in 0..<count {
            self.childVcs.removeLast()
        }
        for childvc in (self.parentVc?.childViewControllers)! {
            print("unremoveChildVC-",childvc)
            print("i=", i)
            if i > (lastChildVcsCount - count - 1) {
                print("removechildVC",childvc)
                childvc.removeFromParentViewController()
            }
            i += 1
        }
        for childs in self.childVcs {
            parentVc?.addChildViewController(childs)
        }
    }
    
}
