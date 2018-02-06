//
//  ZCAccount.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import HandyJSON

class ZCAccount : Codable,HandyJSON{
    
    /// 昵称
    var nickname : String?
    
    /// 性别
    var gender : String?
    
    /// 头像url 30x30
    var figureurl : String?
    
    /// 头像url 50x50
    var figureurl_1 : String?
    
    /// 头像url 100x100
    var figureurl_qq_2 : String?
    
    required init() {}
    
}
