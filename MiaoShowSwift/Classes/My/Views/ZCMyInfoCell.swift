//
//  ZCMyInfoCell.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/6.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMyInfoCell: UITableViewCell {
    
    var cellModel : ZCMyInfoCellModel! {
        
        didSet{
            dealData()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    //MARK: Pravite
    
    private func createUI(){
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints {
            $0.centerY.equalTo(self.contentView)
            $0.left.equalTo(self.contentView).offset(20)
        }
        
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerY.equalTo(self.contentView)
            $0.left.equalTo(self.icon.snp.right).offset(10)
        }
        
        contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints {
            $0.right.equalTo(self.contentView).offset(-10)
            $0.centerY.equalTo(self.contentView)
        }
        
        contentView.addSubview(textLb)
        textLb.snp.makeConstraints {
            $0.right.equalTo(self.rightImageView.snp.left).offset(-5)
            $0.centerY.equalTo(self.contentView)
        }
    }
    
    private func dealData(){
        
        icon.image = UIImage(named: cellModel.iconName)
        
        titleLb.textColor = cellModel.titleColor
        titleLb.text = cellModel.title
        
        textLb.text = cellModel.text
        textLb.textColor = cellModel.textColor
        if cellModel.imageName.count > 0 {
            rightImageView.image = UIImage(named: cellModel.imageName)
        }else{
            rightImageView.image = nil
        }
        
        
        switch cellModel.cellType {
        case .text:
            textLb.snp.remakeConstraints {
                $0.right.equalTo(self.contentView).offset(-10)
                $0.centerY.equalTo(self.contentView)
            }
        default:
            textLb.snp.remakeConstraints {
                $0.right.equalTo(self.rightImageView.snp.left).offset(-5)
                $0.centerY.equalTo(self.contentView)
            }
        }
    }
    
    //MARK: Lazy
    
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var titleLb : UILabel = {
        let titleLb = UILabel()
        titleLb.textColor = UIColor.black
        titleLb.font = UIFont.systemFont(ofSize: 15)
        return titleLb
    }()
    
    private lazy var textLb : UILabel = {
        let textLb = UILabel()
        textLb.font = UIFont.systemFont(ofSize: 12)
        return textLb
    }()
    
    private lazy var rightImageView : UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
}
