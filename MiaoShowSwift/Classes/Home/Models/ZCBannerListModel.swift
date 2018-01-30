//
//  ZCBannerListModel.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/29.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import HandyJSON

class ZCBannerModel: HandyJSON {
    
    /// 标题
    var title : String?
    
    /// 图片
    var imageUrl : String?
    
    /// 跳转链接
    var link : String?
    
    /// 内容
    var contents : String?
    

    var cutTime : Int = 0
    
    /// 服务器id
    var serverid : Int = 0
    
    /// 房间id
    var roomid : Int = 0
    
    /// 不知道啥意思
    var showmodel : Int = 0
    
    required init(){}
}

class ZCBannerListModel: HandyJSON {

    var customData : [ZCBannerModel]?
    required init(){}
}
