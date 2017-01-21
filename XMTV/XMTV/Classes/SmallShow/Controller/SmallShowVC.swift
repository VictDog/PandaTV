//
//  SmallShowVC.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class SmallShowVC: UIViewController {
    // MARK: - 由于用青花瓷没有抓取到请求，就用webView直接加载熊猫TV官网 小葱秀地址。显示效果差不多
    /// 注意: 控制台打印跟 webView.loadRequest(request)这句代码有关，只要loadRequest就会出现个打印，这个可能是应为ios10 SDK的问题，这个虽然看起来不爽，但是不影响程序正常运行。暂时没有找到解决方法。
    
    /* objc[22562]: Class PLBuildVersion is implemented in both /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/AssetsLibraryServices.framework/AssetsLibraryServices (0x127e44910) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/PhotoLibraryServices (0x127c6e210). One of the two will be used. Which one is undefined.
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        let webView = UIWebView(frame: CGRect(x: 0, y: 20, width: kScreenW, height: kScreenH-49))
        webView.delegate = self
        view.addSubview(webView)
        webView.scrollView.bounces = false
        let request = URLRequest(url: URL(string: "http://cong.panda.tv")!)
        webView.loadRequest(request)
    }
}

extension SmallShowVC: UIWebViewDelegate{
    // 因为点击WebView上的播放按钮，会跳转其他页面， 这里禁止跳转
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.description.contains("https://m.panda.tv/room.html") {
            return false
        } else {
            return true
        }
    }
}


