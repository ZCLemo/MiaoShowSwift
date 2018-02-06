//
//  ZCMyInfoCellModel.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/6.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit


/// cell样式类型
///
/// - none: 啥都没
/// - text: 文字
/// - image: 图片
/// - textAndImage: 文字加图片
enum ZCMyInfoCellAppearanceType {
    case none
    case text
    case image
    case textAndImage
}

class ZCMyInfoCellModel {
    
    var title : String!
    var iconName : String!
    var text : String!
    var imageName : String!
    var titleColor : UIColor!
    var textColor : UIColor!
    var cellType : ZCMyInfoCellAppearanceType
    init(title:String!,iconName:String!,text:String!,imageName:String!,titleColor:UIColor!,textColor:UIColor,cellType:ZCMyInfoCellAppearanceType){
        self.title = title
        self.iconName = iconName
        self.text = text
        self.imageName = imageName
        self.titleColor = titleColor
        self.textColor = textColor
        self.cellType = cellType
    }
}
