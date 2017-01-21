//
//  CollectionHeaderView.swift
//  XMTV
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

protocol CollectionHeaderViewDelegate: class {
    func moreLivingList(cataName: String, titleName: String)
}

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var arrowBtn: UIButton!
    
    weak var delegate: CollectionHeaderViewDelegate?
    
    var total: Int? {
        didSet {
            if total! <= 4 {
                moreBtn.isHidden  = true
                arrowBtn.isHidden = true
            } else {
                moreBtn.isHidden  = false
                arrowBtn.isHidden = false
            }
        }
    }
    // MARK:- 定义模型属性
    var group : TypeModel? {
        didSet {
            titleLabel.text = group?.value(forKeyPath: "cname") as! String?
            guard let url = URL(string: ((group?.value(forKeyPath: "icon") as! String?)!)) else { return }
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "defult_h_icon_13x13_"))
        }
    }
    
    // MARK: - 点击更多按钮
    @IBAction func moreClick(_ sender: UIButton) {
        let s1 = (group?.value(forKeyPath: "ename") as! String?)
        let s2 = titleLabel.text
        delegate?.moreLivingList(cataName: s1!, titleName: s2!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
