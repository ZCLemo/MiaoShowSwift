//
//  ZCHotLiveCollectionViewCell.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/30.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCHotLiveCollectionViewCell: UICollectionViewCell {
    
    var hotLive = ZCLiveModel() {
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
        
        contentView.addSubview(audienceIcon)
        audienceIcon.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(10)
            $0.right.equalTo(self.contentView).offset(-10)
            $0.size.equalTo(CGSize.init(width: 59, height: 16))
        }
        
        audienceIcon.addSubview(audienceLabel)
        audienceLabel.snp.makeConstraints {
            $0.right.top.bottom.equalTo(self.audienceIcon)
            $0.left.equalTo(self.audienceIcon).offset(15)
        }
        
        contentView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(self.contentView).offset(10)
            $0.bottom.equalTo(self.contentView).offset(-40)
            
        }
        
        contentView.addSubview(levelIcon)
        levelIcon.snp.makeConstraints {
            $0.left.equalTo(self.nickNameLabel.snp.right).offset(10)
            $0.centerY.equalTo(self.nickNameLabel)
            $0.size.equalTo(CGSize(width: 40, height: 19))
        }
        
        contentView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints {
            $0.left.equalTo(self.nickNameLabel)
            $0.top.equalTo(self.nickNameLabel.snp.bottom).offset(5)
            $0.size.equalTo(CGSize(width: 12, height: 14))
        }
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.left.equalTo(self.locationIcon.snp.right).offset(5)
            $0.centerY.equalTo(self.locationIcon)
        }
    }
    
    
    /// 赋值
    private func dealData(){
        
        backgroundImageView.zc_setImage(urlStr: hotLive.bigpic, placeHolderImage: UIImage(named: "placeholder_head"))
        
        audienceLabel.text = String(hotLive.allnum)
        
        nickNameLabel.text = hotLive.myname
        
        levelIcon.image = UIImage(named: "girl_star\(hotLive.starlevel)_40x19")
        
        locationLabel.text = hotLive.gps
    }
    
    //MARK: Lazy
    
    private lazy var backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        return backgroundImageView
    }()
    
    private lazy var audienceIcon : UIImageView = {
        let audienceIcon = UIImageView()
        audienceIcon.image = UIImage.init(named: "homeLive_flag_small")
        return audienceIcon
    }()
    
    private lazy var audienceLabel : UILabel = {
        let audienceLabel = UILabel()
        audienceLabel.textColor = UIColor.white
        audienceLabel.textAlignment = .center
        audienceLabel.font = UIFont.systemFont(ofSize: 10)
        return audienceLabel
    }()
    
    private lazy var nickNameLabel : UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.textColor = UIColor.white
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        return nickNameLabel
    }()
    
    private lazy var levelIcon : UIImageView = {
        let levelIcon = UIImageView()
        return levelIcon
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
}

//MARK: Public
extension ZCHotLiveCollectionViewCell{
    
    class func cellHeight() -> CGFloat{
        return kScreenWidth
    }
}
