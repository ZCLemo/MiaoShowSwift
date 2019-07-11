//
//  ZCLiveListModel.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/29.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import HandyJSON

class ZCLiveModel: HandyJSON {
    
    /// 图片地址
    var photo : String = ""
    /// 昵称
    var myname : String = ""
    
    /// 直播图
    var bigpic : String = ""
    
    /// 主播头像
    var smallpic : String = ""
    
    /// 直播流地址
    var flv : String = ""

    /// 所在城市
    var gps : String = ""
    
    /// 个性签名
    var signatures : String = ""
    
    /// 用户ID
    var userId : String = ""
    
    /// 用户IDx
    var useridx : String = ""
    
    /// 星级
    var starlevel : UInt = 0
    
    /// 朝阳群众数目
    var allnum : UInt = 0
    
    /// 直播房间号码
    var roomid : UInt = 0
    
    ///所处服务器
    var serverid : UInt = 0
    
    /// 排名
    var pos : UInt = 0
    
    required init() {}
}

class ZCLiveListModel: HandyJSON {
    
    var counts : Int = 0
    
    var list : [ZCLiveModel] = [ZCLiveModel]()
    
    required init() {}
}

