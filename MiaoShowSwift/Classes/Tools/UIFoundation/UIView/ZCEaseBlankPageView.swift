//
//  ZCEaseBlankPageView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCEaseBlankPageView: UIView {
    
    var desc : String? {
        didSet{
            descLb.text = desc
        }
    }
    
    var imageName : String? {
        didSet{
            if imageName == nil {
                return
            }
            imageView.image = UIImage.init(named: imageName!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Pravite
    
    private func createUI(){
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(self).offset(150)
            $0.centerX.equalTo(self)
        }
        
        addSubview(descLb)
        descLb.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(10)
            $0.centerX.equalTo(self)
        }
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.top.equalTo(descLb.snp.bottom).offset(20)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 200, height: 40))
        }
    }
    
    //MARK: Lazy
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var descLb : UILabel = {
        let descLb = UILabel()
        descLb.textAlignment = NSTextAlignment.center
        descLb.font = UIFont.systemFont(ofSize: 15)
        descLb.textColor = UIColor.lightGray
        return descLb
    }()
    
    private lazy var skipButton : UIButton = {
        let skipButton = UIButton.init(type: .custom)
        skipButton.setTitle("去看看当前热门直播", for: .normal)
        skipButton.setTitleColor(UIColor.rgbColor(red: 254, green: 95, blue: 154), for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        skipButton.layer.cornerRadius = 20
        skipButton.layer.borderColor = UIColor.rgbColor(red: 254, green: 95, blue: 154).cgColor
        skipButton.layer.borderWidth = 1
        return skipButton
    }()
}
