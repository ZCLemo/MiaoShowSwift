//
//  ZCMyInformationHeaderView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/5.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMyInformationHeaderView: UIView {
    
    var accountInfo : ZCAccount? {
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
        
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        addSubview(avater)
        avater.snp.makeConstraints {
            $0.top.equalTo(self).offset(40)
            $0.left.equalTo(self).offset(40)
            
            $0.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        addSubview(nameLb)
        nameLb.snp.makeConstraints {
            $0.left.equalTo(avater.snp.right).offset(10)
            $0.top.equalTo(self).offset(60)
        }
        
        addSubview(sexIcon)
        sexIcon.snp.makeConstraints {
            $0.centerY.equalTo(nameLb)
            $0.left.equalTo(nameLb.snp.right).offset(10)
        }
        
        addSubview(manifestoLb)
        manifestoLb.snp.makeConstraints {
            $0.left.equalTo(nameLb)
            $0.top.equalTo(nameLb.snp.bottom).offset(10)
            
        }
    }
    
    private func dealData(){
        
        avater.zc_setImage(urlStr: accountInfo?.figureurl_qq_2, placeHolderImage: nil)
        
        nameLb.text = accountInfo?.nickname
        
        if accountInfo?.gender != nil {
            sexIcon.image = accountInfo!.gender == "男" ? UIImage.init(named: "man") : UIImage.init(named: "woman")
        }
    }
    
    //MARK: Lazy
    
    private lazy var backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "theme_bg")
        return backgroundImageView
    }()
    
    private lazy var avater : UIImageView = {
        let avater = UIImageView()
        avater.layer.cornerRadius = 50
        avater.clipsToBounds = true
        return avater
    }()
    
    private lazy var nameLb : UILabel = {
        let nameLb = UILabel()
        nameLb.textColor = UIColor.white
        nameLb.font = UIFont.systemFont(ofSize: 20)
        return nameLb
    }()
    
    private lazy var sexIcon : UIImageView = {
        let sexIcon = UIImageView()
        return sexIcon
    }()
    
    private lazy var manifestoLb : UILabel = {
        let manifestoLb = UILabel()
        manifestoLb.textColor = UIColor.white
        manifestoLb.font = UIFont.systemFont(ofSize: 15)
        manifestoLb.text = "这家伙很懒，什么都没说"
        return manifestoLb
    }()
}

//MARK: Public

extension ZCMyInformationHeaderView{
    
    func scaleBackgroundImageView(contentOffset:CGPoint){
        
        let originH = self.bounds.size.height
        let originW = self.bounds.size.width
        
        if contentOffset.y<0 {
            let deltH = -contentOffset.y
            let deltW = ((deltH + originH)/originH - 1.0) * originW/2.0
        
            backgroundImageView.snp.remakeConstraints {
                $0.left.equalTo(self).offset(-deltW)
                $0.right.equalTo(self).offset(deltW)
                $0.top.equalTo(self).offset(contentOffset.y)
                $0.bottom.equalTo(self)
            }
            
        }else{
            
            backgroundImageView.snp.remakeConstraints {
                $0.edges.equalTo(self)
            }
        }
        
    }
    
}
