//
//  ZCLiveInfomationView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/8.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCLiveInfomationView: UIView {
    
    var live = ZCLiveModel() {
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
        addSubview(avater)
        avater.snp.makeConstraints {
            $0.left.equalTo(self).offset(5)
            $0.centerY.equalTo(self)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(attentionButton)
        attentionButton.snp.makeConstraints {
            $0.right.equalTo(self).offset(-5)
            $0.centerY.equalTo(self)
            $0.size.equalTo(CGSize.init(width: 50, height: 40))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(self.avater.snp.right).offset(5)
            $0.right.equalTo(self.attentionButton.snp.left).offset(-5)
            $0.top.equalTo(self.avater)
        }
        
        addSubview(attentionsLabel)
        attentionsLabel.snp.makeConstraints {
            $0.left.right.equalTo(nameLabel)
            $0.bottom.equalTo(self.avater)
        }
    }
    
    private func dealData(){
        avater.zc_setImage(urlStr: live.smallpic, placeHolderImage: nil)
        nameLabel.text = live.myname
        attentionsLabel.text = String(live.allnum) + "人"
    }
    
    //MARK: Lazy
    
    private lazy var avater : UIImageView = {
        let avater = UIImageView()
        avater.layer.cornerRadius = 20
        avater.clipsToBounds = true
        return avater
    }()
    
    private lazy var attentionButton : UIButton = {
        let attentionButton = UIButton(type: .custom)
        attentionButton.setTitle("关注", for: .normal)
        attentionButton.layer.cornerRadius = 20
        attentionButton.clipsToBounds = true
        attentionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        attentionButton.backgroundColor = UIColor.rgbColor(red: 254, green: 95, blue: 154)
        return attentionButton
    }()
    
    private lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        return nameLabel
    }()
    
    private lazy var attentionsLabel : UILabel = {
        let attentionsLabel = UILabel()
        attentionsLabel.textColor = UIColor.white
        attentionsLabel.font = UIFont.systemFont(ofSize: 12)
        return attentionsLabel
    }()
}
