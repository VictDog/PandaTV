//
//  CollectionNormalCell.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var anchor : LivelistModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr : String = ""
            if anchor.person_num >= 10000 {
                onlineStr = String(format:"%.1f万",Float(anchor.person_num) / 10000)
            } else {
                onlineStr = "\(anchor.person_num)"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            nickNameLabel.text = anchor.name
            
            if let picture = anchor.pictures {
                guard let iconURL = URL(string: picture["img"] as! String) else { return }
                iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "homepage_refresh_tv"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
            }
            
            if let userInfo = anchor.userinfo {
                nameLabel.text = userInfo["nickName"] as? String
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.contentMode = .scaleAspectFit
    }

}
