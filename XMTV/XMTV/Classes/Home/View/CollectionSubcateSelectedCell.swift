//
//  CollectionSubcateSelectedCell.swift
//  XMTV
//
//  Created by Mac on 2017/1/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class CollectionSubcateSelectedCell: UICollectionViewCell {

    @IBOutlet weak var itemButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemButton.setBackgroundImage(UIImage(named: "pindaoxuanze_changyong_button_normal"), for: .normal)
        itemButton.setBackgroundImage(UIImage(named: "pindaoxuanze_changyong_button_press"), for: .highlighted)
    }

    var subcateModel: GameModel? {
        didSet {
            itemButton.setTitle(subcateModel?.cname, for: .normal)
        }
    }
}
