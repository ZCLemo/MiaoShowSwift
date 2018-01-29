//
//  ZCBannerView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

@objc protocol ZCBannerViewDataSource : class {
    
    @objc func numberOfItems() -> Int
    
    @objc func bannerView(bannerView:ZCBannerView,itemForBannerViewAt index:Int) -> UIView
}

@objc protocol ZCBannerViewDelegate : class {
    
    @objc optional func bannerViewDidSelect(index:Int)
    
    @objc optional func bannerViewWillAppear(index:Int)
}

class ZCBannerView: UIView {
    
    let itemViewTag = 1000
    
    /// 默认3s滚动一次
    var interval : TimeInterval = 3
    
    /// 是否手动滑动
    var isDraging : Bool = false
    
    /// 图片的张数
    var count = 0
    
    weak var dataSource : ZCBannerViewDataSource?
    
    weak var delegate : ZCBannerViewDelegate?
    
    var timer : Timer?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
    }
    
    //MARK: Pravite
    
    private func createUI(){
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    
    /// 销毁timer
    private func invalidateTimer(){
        if timer != nil && timer!.isValid {
            timer!.invalidate()
            timer = nil
        }
    }

    
    /// 循环滚动
    @objc private func timerLoop(){
        UIView.animate(withDuration: 0.3, animations: {
            var contentOffset = self.scrollView.contentOffset
            contentOffset.x = contentOffset.x + self.w
            self.scrollView.contentOffset = contentOffset
        }) { (finished) in
            self.changeContentOffset()
        }
    }
    
    /// 循环滚动
    private func changeContentOffset(){
        var contentOffset = scrollView.contentOffset
        let pageIndex = Int(contentOffset.x/self.w)
        if pageIndex >= count {
            contentOffset.x = 0
            scrollView.contentOffset = contentOffset
        }
    
        let index = pageIndex%count
        if delegate == nil{
            return
        }
        delegate!.bannerViewWillAppear?(index: index)
    }
    
    @objc private func tapClick(gesture:UITapGestureRecognizer){
        let itemView = gesture.view!
        let index = (itemView.tag - itemViewTag+count-1)%count
        if delegate == nil {
            return
        }
        delegate!.bannerViewDidSelect?(index: index)
    }
    
    //MARK: Lazy
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
}


//MARK: Public
extension ZCBannerView{
    
    /// 刷新
    func reloadData(){
        
        if self.dataSource == nil {
            return
        }
        
        for subView in self.scrollView.subviews {
            subView.removeFromSuperview()
        }
        
        count = dataSource!.numberOfItems()
        
        if count == 0 {
            scrollView.contentSize = .zero
            scrollView.contentInset = .zero
            return
        }
        
        scrollView.contentInset = count>1 ? UIEdgeInsets.init(top: 0, left: self.w, bottom: 0, right: self.w) : UIEdgeInsets.zero
        scrollView.contentSize = CGSize(width: CGFloat(count)*self.w, height: self.h)
        
        for i in 0..<count+2 {
            let index = (i+count-1) % count
            let itemView = dataSource!.bannerView(bannerView: self, itemForBannerViewAt: index)
            itemView.isUserInteractionEnabled = true
            itemView.frame = CGRect.init(x: CGFloat(i-1)*self.w, y: 0, width: self.w, height: self.h)
            itemView.tag = itemViewTag + i
            scrollView.addSubview(itemView)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(gesture:)))
            itemView.addGestureRecognizer(tap)
        }
        
        //多于一张时添加循环滚动
        if count > 1 {
            invalidateTimer()
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerLoop), userInfo: nil, repeats: true)
        }
        
    }
}

extension ZCBannerView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isDraging {
            return
        }
        
        var currentIndex = 0
        var contentOffset = scrollView.contentOffset
        if Int(contentOffset.x/self.w) == count{//最后一页
            currentIndex = 0
            contentOffset.x = 0
            scrollView.contentOffset = contentOffset
        }else if Int(contentOffset.x/self.w) == -1 {//第一页
            currentIndex = count-1
            contentOffset.x = CGFloat(currentIndex)*self.w
            scrollView.contentOffset = contentOffset
        }else{
            currentIndex = Int(contentOffset.x/self.w)
        }
        
        if delegate == nil {
            return
        }
        delegate!.bannerViewWillAppear?(index: currentIndex)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //挂起定时器
        timer!.fireDate = Date.distantFuture
        isDraging = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isDraging = false
        timer!.fireDate = Date(timeIntervalSinceNow: interval)
    }
}
