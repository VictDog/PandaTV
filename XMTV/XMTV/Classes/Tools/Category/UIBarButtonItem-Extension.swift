//
//  UIBarButtonItem-Extension.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName : String, highlightedImage : String = "" , size : CGSize = CGSize.zero, target:UIViewController, action:Selector) {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highlightedImage != ""{
            btn.setImage(UIImage(named : highlightedImage), for: .highlighted)
        }
        if size != CGSize.zero{
            btn.frame = CGRect (origin: CGPoint.zero, size: size)
        }else
        {
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
