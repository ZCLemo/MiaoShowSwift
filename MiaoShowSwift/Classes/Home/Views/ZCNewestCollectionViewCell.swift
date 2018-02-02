//
//  ZCNewestCollectionViewCell.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCNewestCollectionViewCell: UICollectionViewCell {
    
    var newestLive : ZCNewestLiveModel?{
        didSet{
            dealData()
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
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
        
        contentView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints {
            $0.left.top.equalTo(self.contentView).offset(10)
            $0.size.equalTo(CGSize(width: 12, height: 14))
        }
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.left.equalTo(self.locationIcon.snp.right).offset(5)
            $0.centerY.equalTo(self.locationIcon)
        }
        
        let itemWH = ZCNewestCollectionViewCell.getItemWH()
        contentView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(self.contentView).offset(5)
            $0.bottom.equalTo(self.contentView).offset(-10)
            $0.width.lessThanOrEqualTo(itemWH - 55)
        }
        
        contentView.addSubview(levelIcon)
        levelIcon.snp.makeConstraints {
            $0.left.equalTo(self.nickNameLabel.snp.right).offset(5)
            $0.centerY.equalTo(self.nickNameLabel)
            $0.size.equalTo(CGSize(width: 40, height: 19))
        }
    }
    
    private func dealData(){
        
        self.layer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
        backgroundImageView.zc_setImage(urlStr: newestLive?.photo, placeHolderImage: UIImage.init(named: "placeholder_head")) { (image, error, tpe, url) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)

            })
        }
        
        locationLabel.text = newestLive?.position
        
        nickNameLabel.text = newestLive?.nickname
        
        levelIcon.image = UIImage(named: "girl_star\(newestLive?.starlevel ?? 1)_40x19")
    }
    
    
    /// item宽高
    ///
    /// - Returns: item宽高
    class func getItemWH() -> CGFloat{
        let itemWH = (kScreenWidth-CGFloat(4))/3
        return itemWH
    }
    
    
    /// 行间距
    ///
    /// - Returns: 2
    class func itemSpace() -> CGFloat{
        return 2
    }
    
    /// 每行个数
    ///
    /// - Returns: 3
    class func rowCount() -> CGFloat{
        return 3
    }
    
    //MARK: Lazy
    
    private lazy var backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        return backgroundImageView
    }()
    
    private lazy var locationIcon : UIImageView = {
        let locationIcon = UIImageView()
        locationIcon.image = UIImage.init(named: "home_location")
        return locationIcon
    }()
    
    private lazy var locationLabel : UILabel = {
        let locationLabel = UILabel()
        locationLabel.textColor = UIColor.white
        locationLabel.font = UIFont.systemFont(ofSize: 10)
        return locationLabel
    }()
    
    
    private lazy var nickNameLabel : UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.textColor = UIColor.white
        nickNameLabel.font = UIFont.systemFont(ofSize: 12)
        return nickNameLabel
    }()
    
    private lazy var levelIcon : UIImageView = {
        let levelIcon = UIImageView()
        return levelIcon
    }()
    
}
