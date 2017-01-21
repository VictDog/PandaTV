//
//  AllSubcateVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let kItemW: CGFloat = (kScreenW - 6 * kItemMargin) / 3
private let kItemH: CGFloat = 30
private let kSubcataCellID: String = "kSubcataCellID"

// 返回选择的频道数组
typealias backChannelBlock = ([GameModel]) -> ()

class AllSubcateVC: UIViewController {
    
//    let common = Common()
    // 频道数组Block
    var channelBlock: backChannelBlock?
    // 所有分类的模型和游戏界面的分类一样，所以就直接用游戏模型了
    fileprivate lazy var unselectedChannels = [GameModel]() // 未选择的频道
    fileprivate lazy var selectedChannels = [GameModel]()   // 已选择的频道
    fileprivate lazy var channels = [GameModel]()           // 频道数组
    /// 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = kItemMargin
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionSubcateCell", bundle: nil), forCellWithReuseIdentifier: kSubcataCellID)
        collectionView.register(HeadView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "HeadView")
        // 添加长按手势
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(viewCustom(_ :)))
        collectionView.addGestureRecognizer(gesture)
        
        return collectionView
    }()
    
    // MARK: - lafe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let selected = common.unarchiveData(appendPath: SELECTED_CHANNELS)
        let unSelected = common.unarchiveData(appendPath: UNSELECTED_CHANNELS)
        
//        print("selected, unselected", selected, unSelected)
        if ((selected == nil)||(unSelected == nil)) {
            requestData()
        } else {
            self.selectedChannels = selected!
            self.unselectedChannels = unSelected!
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        // 当返回首页的时候，就将频道数组传递出去
        var selectCate: [GameModel] = [GameModel]()
        if channels.count > 0 {
            self.channelBlock!(channels)
            selectCate = channels
            common.archiveData(channel: channels, appendPath: SELECTED_CHANNELS)
        } else {
            if (self.selectedChannels.count > 0) {
                self.channelBlock!(self.selectedChannels)
                selectCate = self.selectedChannels
                common.archiveData(channel: self.selectedChannels, appendPath: SELECTED_CHANNELS)
            } else {
                self.channelBlock!([GameModel]())
                common.archiveData(channel: [GameModel](), appendPath: SELECTED_CHANNELS)
            }
        }
        common.archiveData(channel: self.unselectedChannels, appendPath: UNSELECTED_CHANNELS)
        NotificationCenter.default.post(name: NotifyUpdateCategory, object: nil, userInfo: [KSelectedChannel: selectCate])
    }
    
}

// MARK: - 长按排序
extension AllSubcateVC {
    
    @objc fileprivate func viewCustom(_ longPress:UILongPressGestureRecognizer){
        let point: CGPoint = longPress.location(in: longPress.view)
        guard let indexpath = self.collectionView.indexPathForItem(at: point) else { return }
        
        switch longPress.state {
        
        case .began:
            self.collectionView.beginInteractiveMovementForItem(at: indexpath)
            break
            
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(point)
            break
            
        case .ended:
            self.collectionView.endInteractiveMovement()
            break
            
        default:
            self.collectionView.cancelInteractiveMovement()
            break
        }
    }
}


extension AllSubcateVC {
    // MARK: - 设置ui
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        title = "频道选择"
        view.addSubview(collectionView)
    }
    
    // MARK: - 发送请求
    fileprivate func requestData() {
        // http://api.m.panda.tv/ajax_get_all_subcate?__version=1.1.7.1305&__plat=ios&__channel=appstore
        NetworkTool.request(type: .GET, urlString: "http://api.m.panda.tv/ajax_get_all_subcate", paramters: ["__version":"1.1.7.1305", "__plat":"ios", "__channel":"appstore"]) { (result) in
            // 将result 转成字典
            guard let resultDict = result as? [String: NSObject] else { return }
            // 根据data读key，获取数组
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            for dict in dataArray {
                let allSubcate = GameModel(dict: dict)
                self.unselectedChannels.append(allSubcate)
            }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - 遵守协议
extension AllSubcateVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectedChannels.count
        } else {
            return self.unselectedChannels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSubcataCellID, for: indexPath) as! CollectionSubcateCell
        if indexPath.section == 0 {
            cell.subcateModel = self.selectedChannels[indexPath.item]
        } else {
            cell.subcateModel = self.unselectedChannels[indexPath.item]
        }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            self.selectedChannels.append(self.unselectedChannels[indexPath.item])
            self.unselectedChannels.remove(at: indexPath.item)
            let indexPath1 = NSIndexPath.init(item: selectedChannels.count-1, section: 0)
            let indexPath2 = NSIndexPath.init(item: indexPath.item, section: 1)
            //从当前位置移动到新的位置
            collectionView.moveItem(at: indexPath2 as IndexPath, to: indexPath1 as IndexPath)
        } else {
            self.unselectedChannels.append(self.selectedChannels[indexPath.item])
            self.selectedChannels.remove(at: indexPath.item)
            let path1 = NSIndexPath.init(item: unselectedChannels.count-1, section: 1)
            let path2 = NSIndexPath.init(item: indexPath.item, section: 0)
            collectionView.moveItem(at: path2 as IndexPath, to: path1 as IndexPath)
        }
        
        self.collectionView.reloadData()
        
    }

    // MARK: - 头部视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeadView", for: indexPath) as! HeadView
        
        if indexPath.section == 0 {
            headView.title = "常用频道(长按可拖动调整频道顺序，点击删除)"
        } else {
            headView.title = "所有频道(点击添加您感兴趣的频道)"
        }
        
        let attributeStr = NSMutableAttributedString(string: headView.title)
        attributeStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14.0),range: NSMakeRange(0,4))
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, 4))
        headView.label.attributedText = attributeStr
    
        return headView
    }
    
    // MARK: - 设置HeaderView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 44)
    }
    
    // MARK: - 是否可以移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 设置拖动(手势拖动触发)
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
            collectionView.exchangeSubview(at: sourceIndexPath.item, withSubviewAt: destinationIndexPath.item)
        }
//        print("sourceIndexPath", sourceIndexPath)
//        print("destinationIndexPath", destinationIndexPath)
//        print("selectedChannels",self.selectedChannels)
        let array = NSMutableArray(array: self.selectedChannels)
        array.exchangeObject(at: sourceIndexPath.item, withObjectAt: destinationIndexPath.item)
        for model in array {
            self.channels.append(model as! GameModel)
        }
//        print("channels",channels)
    }
}

// MARK: - collection headerView
class HeadView: UICollectionReusableView {
    
    lazy var line: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        view.backgroundColor = BGCOLOR
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW-10, height: self.bounds.size.height - 10))
        label.textColor = UIColor.lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    var title = "" { didSet { label.text = title } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(line)
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

