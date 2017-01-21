//
//  PageMenuView.swift
//  XMTV
//
//  Created by Mac on 2017/1/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

private let selectedColor = UIColor(r: 108, g: 198, b: 152)
private let normalColor = UIColor.darkGray
private let kScrollLineH: CGFloat = 4
private let lineH: CGFloat = 0.5
private let kAddButtonW:CGFloat = 40

// MARK: - 代理
protocol PageMenuViewDelegate: class {
    func pageMenuView(_ titleView : PageMenuView, selectedIndex index : Int)
}

class PageMenuView: UIView {
    // MARK: - 代理
    weak var delegate: PageMenuViewDelegate?
//    let common = Common()
    fileprivate var channels: [GameModel] = [GameModel]()
    fileprivate var currentButtonIndex :Int = 0
    // 默认的title就是精彩推荐和全部直播
    fileprivate var titles :[String] = ["精彩推荐", "全部直播"]
    fileprivate lazy var titleButtons: [UIButton] = [UIButton]()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    fileprivate lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addbutton_43x40_"), for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(self.addItemClick), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = selectedColor
        return scrollLine
    }()
    
//    , titles: [String]
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.frame = bounds
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageMenuView {
    // MARK: - 设置UI
    fileprivate func setupUI() {
        addSubview(rightButton)
        rightButton.frame = CGRect(x: kScreenW - kAddButtonW, y: 0, width: kAddButtonW, height: self.frame.size.height)
        setupTitleButtons()
        setupButtomLine()
        titleButtonClick(sender: titleButtons[0])
    }
    
    // MARK: - 设置标题按钮
    fileprivate func setupTitleButtons() {
        let bW: CGFloat = frame.width / 3
        let bH: CGFloat = frame.height - kScrollLineH
        let bY: CGFloat = 0
        
        let newtitles = common.unarchiveToStringArray(appendPath: PAGE_TITLES)
        if newtitles != nil {
            self.titles = newtitles!
            print("newtitles-", self.titles)
        }
        
        print("titles-", self.titles)
        for (index, title) in titles.enumerated() {
            let button = UIButton()
            button.tag = index
            let img = titleToSting(title: title)
            var image = ""
            if index == 0 { image = img + "_h_icon_13x13_" } else { image = img + "_icon_13x13_" }
            button.setImage(UIImage(named: image), for: .normal)
            button.setTitle(title, for: .normal)
            button.setTitleColor(normalColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            let bX: CGFloat = bW * CGFloat(index)
            button.frame = CGRect(x: bX, y:bY , width: bW, height: bH)
            scrollView.addSubview(button)
            titleButtons.append(button)
            button.addTarget(self, action: #selector(self.titleButtonClick(sender:)), for: .touchUpInside)
        }
        scrollView.contentSize = CGSize(width: bW * CGFloat(titles.count), height: 0)
    }
    
    // MARK: - 设置底部分割线
    fileprivate func setupButtomLine() {
        let buttomLine: UIView = UIView()
        buttomLine.backgroundColor = normalColor
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        guard let firstButton = titleButtons.first else { return }
        firstButton.setTitleColor(selectedColor, for: .normal)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstButton.frame.origin.x + firstButton.frame.width * 0.1, y: frame.height - kScrollLineH, width: firstButton.frame.width * 0.8, height: kScrollLineH)
    }

}

// MARK: - 点击标题按钮
extension PageMenuView {
    
    // MARK: - 点击标题按钮
    @objc fileprivate func titleButtonClick(sender: UIButton) {
        setupTitleCenter(button: sender)
        if sender.tag == currentButtonIndex { return }
        if currentButtonIndex > titleButtons.count - 1 {
            currentButtonIndex = titleButtons.count - 1
        }
        let oldButton = titleButtons[currentButtonIndex]
        
        sender.setTitleColor(selectedColor, for: .normal)
        oldButton.setTitleColor(normalColor, for: .normal)
        
        sender.setImage(UIImage(named: titleToSting(title: sender.currentTitle!) + "_h_icon_13x13_"), for: .normal)
        oldButton.setImage(UIImage(named: titleToSting(title: oldButton.currentTitle!) + "_icon_13x13_"), for: .normal)
        currentButtonIndex = sender.tag
        
        let scrollLinePosition = sender.frame.origin.x + sender.frame.width * 0.1
        scrollLine.frame.size.width = sender.frame.width * 0.8
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = scrollLinePosition//X
        })
        
        delegate?.pageMenuView(self, selectedIndex: currentButtonIndex)
        
    }
    // MARK: - 让标题按钮自动居中（如果按钮的中心点 > 屏幕的中心点则将按钮中心点偏移）
    fileprivate func setupTitleCenter(button: UIButton) {
        // 判断标题按钮是否需要移动
        var offsetX = button.center.x - kScreenW * 0.5
        let maxOffsetX = scrollView.contentSize.width - kScreenW
//        print("offsetX",offsetX)
//        print("maxOffsetX",maxOffsetX)
        if (offsetX < 0) {
            offsetX = 0
        }
        
        if (offsetX > maxOffsetX) {
            // 当处于最后一个标题按钮并且maxOffsetX > 0 的时候，为防止被最右边添加按钮挡住，需要增加一个偏移
            if button.tag == (self.titles.count - 1) {
                if maxOffsetX > 0 {
                    offsetX = maxOffsetX + 40
                }
            } else {
                if button.tag != 0 {
                    offsetX = maxOffsetX
                }
            }
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    
    // MARK: - 点击添加按钮
    @objc fileprivate func addItemClick() {
        if let nextResponder = next?.next, nextResponder.isKind(of: UIViewController.self){
            let vc = nextResponder as! UIViewController
            let subcatevc = AllSubcateVC()
            vc.navigationController?.pushViewController(subcatevc, animated: true)
            subcatevc.channelBlock = { channels in
                var newTitles = ["精彩推荐", "全部直播"]
                for model in channels {
                    newTitles.append(model.cname)
                }
                self.reloadTitles(newTitles)
            }
        }
    }
}

//MARK:- 左右滑动屏幕，切换title时调用这个方法
extension PageMenuView{
    func setTitleWithProgress(_ progress:CGFloat,sourceIndex : Int,targetIndex : Int){
        let sourceButton = titleButtons[sourceIndex]
        let targetButton = titleButtons[targetIndex]
        let moveTotalX = targetButton.frame.origin.x - sourceButton.frame.origin.x
        let moveX = moveTotalX * progress

        sourceButton.setTitleColor(normalColor, for: .normal)
        sourceButton.setImage(UIImage(named: titleToSting(title: sourceButton.currentTitle!) + "_icon_13x13_"), for: .normal)
        targetButton.setTitleColor(selectedColor, for: .normal)
        targetButton.setImage(UIImage(named: titleToSting(title: targetButton.currentTitle!) + "_h_icon_13x13_"), for: .normal)
        
        scrollLine.frame.origin.x = sourceButton.frame.origin.x + sourceButton.frame.width*0.1 + moveX
        currentButtonIndex = targetIndex
    }
}

// MARK: - 刷新PageMenuView
extension PageMenuView {
    fileprivate func reloadTitles(_ channels: [String]) {
        scrollView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        titles.removeAll()
        titleButtons.removeAll()
        // 重新设置UI
        self.titles = channels
        print("self.titles-", self.titles)
        common.archiveWithStringArray(channel: self.titles, appendPath: PAGE_TITLES)
        setupUI()
        // 注意: 将当前的currentButtonIndex更新，因为一旦移除了频道，titleButtons数组更新了，如果不重置，当取出按钮时，则会发生数组越界
        currentButtonIndex = 0
    }
    
    /** 找到当前View所在的控制器
     func getFatherController(view: UIView)-> UIViewController? {
     var next: UIView? = view
     repeat{
     if let nextResponder = next?.next , nextResponder.isKind(of: UIViewController.self){
     return (nextResponder as! UIViewController)
     }
     next = next?.superview
     } while next != nil
     return nil
     }
     */
    
    /// 因为这个标题按钮的图片是从本地加载的，而不是从网络获取的，本来是想将标题转换成小写首字母，但是尝试了多种办法后失败了，所以就用这种笨办法，如果你有更好的办法可以在github上 issu 我， 多谢！！！
    func titleToSting(title :String) -> String {
        if title == "精彩推荐" {return "jptj"}
        else if title == "全部直播" {return "alllive"}
        else if title == "炉石传说" {return "lscs"}
        else if title == "守望先锋" {return "swxf"}
        else if title == "英雄联盟" {return "yxlm"}
        else if title == "户外直播" {return "hwzb"}
        else if title == "主机游戏" {return "zjyx"}
        else if title == "穿越火线" {return "cyhx"}
        else if title == "魔兽世界" {return "mssj"}
        else if title == "风暴英雄" {return "fbyx"}
        else if title == "体育竞技" {return "tujj"}
        else if title == "我的世界" {return "wdsj"}
        else if title == "格斗游戏" {return "gdyx"}
        else if title == "怀旧经典" {return "hjjd"}
        else if title == "战争游戏" {return "zzyx"}
        else if title == "萌宠乐园" {return "mcly"}
        else if title == "皇室战争" {return "hszz"}
        else if title == "熊猫星秀" {return "defult"}
        else if title == "黎明杀机" {return "defult"}
        else if title == "流放之路" {return "defult"}
        else if title == "外服网游" {return "defult"}
        else if title == "网络游戏" {return "defult"}
        else if title == "综合手游" {return "defult"}
        else if title == "捕鱼天地" {return "defult"}
        else if title == "DNF" {return "dxcyys"}
        else if title == "天谕" {return "ty"}
        else if title == "音乐" {return "yyzb"}
        else if title == "桌游" {return "defult"}
        else if title == "饥荒" {return "defult"}
        else if title == "剑网3" {return "jw3"}
        else if title == "阴阳师" {return "dxcyys"}
        else if title == "CS:GO" {return "csgo"}
        else if title == "DOTA2" {return "dota2"}
        else if title == "拳皇97" {return "qh97"}
        else if title == "星际争霸2" {return "xjzb"}
        else if title == "魔兽DOTA1" {return "mssj"}
        else if title == "精灵宝可梦" {return "defult"}
        else if title == "天涯明月刀" {return "ty"}
        else if title == "跑跑卡丁车" {return "ppkdc"}
        else if title == "暗黑破坏神3" {return "ahphs3"}
        else {return ""}
    }
}
