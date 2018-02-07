//
//  ZCHotBannerCollectionViewCell.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCHotBannerCollectionViewCell: UICollectionViewCell {
    
    var bannerList : [ZCBannerModel]! {
        didSet{
            pageControl.numberOfPages = bannerList.count
            bannerView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    //MARK: Pravite
    private func createUI(){
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
        
        contentView.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(self.contentView)
            $0.bottom.equalTo(self.contentView)
            $0.size.equalTo(CGSize.init(width: kScreenWidth, height: 20))
        }
    }
    
    //MARK: Lazy
    private lazy var bannerView : ZCBannerView = {
        let bannerView  = ZCBannerView()
        bannerView.delegate = self
        bannerView.dataSource = self
        return bannerView
    }()
    
    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
}

// MARK: - ZCBannerViewDataSource,ZCBannerViewDelegate
extension ZCHotBannerCollectionViewCell : ZCBannerViewDataSource,ZCBannerViewDelegate{
    
    func numberOfItems() -> Int {
        return bannerList.count
    }

    func bannerView(bannerView: ZCBannerView, itemForBannerViewAt index: Int) -> UIView {
        let banner = bannerList[index]
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: bannerView.w, height: bannerView.h)
        imageView.zc_setImage(urlStr: banner.imageUrl, placeHolderImage: UIImage(named: "placeHolder_ad_414x100"))
        return imageView
    }

    func bannerViewDidSelect(index: Int) {

    }

    func bannerViewWillAppear(index: Int) {
        pageControl.currentPage = index
    }
}

////MARK: Public
extension ZCHotBannerCollectionViewCell{
    class func cellHeight() -> CGFloat{
        return kScreenWidth/CGFloat(414) * CGFloat(100)
    }
}


