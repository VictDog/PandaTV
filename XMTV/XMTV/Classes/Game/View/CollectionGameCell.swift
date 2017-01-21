//
//  CollectionGameCell.swift
//  XMTV
//
//  Created by Mac on 2017/1/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var gameModel: GameModel? {
        didSet {
            guard let iconURL = URL(string: gameModel?.img ?? "") else { return }
            imageView.kf.setImage(with: iconURL)
            nameLabel.text = gameModel?.cname
        }
    }
}
