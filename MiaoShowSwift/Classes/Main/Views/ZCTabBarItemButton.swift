//
//  ZCTabBarItemButton.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/5.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCTabBarItemButton: UIButton {
    
    var selectedImageName : String!
    
    var imageName : String! {
        
        didSet{
            itemIcon.image = UIImage(named: imageName)
            
        }
    }
    
    var itemTitle : String! {
        
        didSet{
            itemTitleLb.text = itemTitle
            
            if itemTitle.count == 0 {
                itemIcon.snp.remakeConstraints({
                    $0.center.equalTo(self)
                })
            }
        }
    }
    
    override var isSelected: Bool {
        didSet{
            itemIcon.image = isSelected ? UIImage(named: selectedImageName) : UIImage(named: imageName)
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
        
        addSubview(itemIcon)
        itemIcon.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(self).offset(-5)
        }
        
        addSubview(itemTitleLb)
        itemTitleLb.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(itemIcon.snp.bottom).offset(-6)
        }
    }
    
    //MARK: Lazy
    
    lazy var itemIcon : UIImageView = {
        let itemIcon = UIImageView()
        return itemIcon
    }()
    
    private lazy var itemTitleLb : UILabel = {
        let itemTitleLb = UILabel()
        itemTitleLb.textColor = UIColor.lightGray
        itemTitleLb.font = UIFont.systemFont(ofSize: 10)
        itemTitleLb.textAlignment = .center
        return itemTitleLb
    }()
    
}
