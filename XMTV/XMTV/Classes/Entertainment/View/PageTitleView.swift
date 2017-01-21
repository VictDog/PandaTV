//
//  PageTitleView.swift
//  XMTV
//
//  Created by Mac on 2017/1/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

// MARK:- 代理1
protocol  PageTitleViewDelegate :class{
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

private let kNormalColor :(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor :(CGFloat,CGFloat,CGFloat) = (108,198,152)
private let kScrollLineH :CGFloat = 4
private let lineH:CGFloat = 0.5

class PageTitleView: UIView {

    //MARK:-  代理2
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate var currentLabelIndex :Int = 0
    fileprivate var titles :[String]
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView ()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        return scrollLine
    }()
    
    init(frame : CGRect, titles : [String]){
        self.titles = titles
        super.init(frame : frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomAndLine()
    }
    
    fileprivate func setupTitleLabels(){
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomAndLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x+firstLabel.frame.width*0.1, y: frame.height-kScrollLineH-lineH, width: firstLabel.frame.width*0.8, height: kScrollLineH)
    }
}

// MARK:- 添加手势
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else { return }
        if currentLabel.tag == currentLabelIndex { return }
        let oldLabel = titleLabels[currentLabelIndex]
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabelIndex = currentLabel.tag
        //        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        let scrollLinePosition = currentLabel.frame.origin.x + currentLabel.frame.width * 0.1
        scrollLine.frame.size.width = currentLabel.frame.width * 0.8
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = scrollLinePosition//X
        })
        
        //MARK:-  代理3
        delegate?.pageTitleView(self, selectedIndex: currentLabelIndex)
    }
}

//MARK:- 公开给外面调用的FUNC
extension PageTitleView {
    func setTitleWithProgress(_ progress:CGFloat,sourceIndex : Int,targetIndex : Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + sourceLabel.frame.width*0.1 + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //
        currentLabelIndex = targetIndex
    }
}

