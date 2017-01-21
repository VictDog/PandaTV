//
//  CollectionCycleCell.swift
//  XMTV
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.bigimg ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "homepage_refresh_tv"))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
