//
//  ZCNewestListModel.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import HandyJSON

class ZCNewestLiveModel: HandyJSON {

    /// 昵称
    var nickname : String?
    
    /// 图片地址
    var photo : String?
    
    /// 性别
    var sex : Int = 0
    
    /// 等级
    var starlevel : Int = 0
    
    /// 观众数
    var allnum : Int = 0
    
    /// 房间id
    var roomid : Int = 0
    
    /// 用户id
    var useridx : Int = 0
    
    /// 推流
    var flv : String?
    
    /// 服务器id
    var serverid : Int = 0
    
    /// 住址
    var position : String?
    
    /// 客户端类型
    var phonetype : Int = 0
    
    /// 是否在线
    var isOnline : Int = 0
    
    /// 家族名称
    var familyName : String?
    
    required init() {}
}

class ZCNewestListModel : HandyJSON {
    
    var totalPage : Int = 0
    var list : [ZCNewestLiveModel]?
    required init() {}
}
