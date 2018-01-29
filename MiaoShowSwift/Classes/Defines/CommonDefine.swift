//
//  CommonDefine.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let kTabbarHeight : CGFloat = 49
var kNavigationBarHeight : CGFloat{
    get{
        if ZCSystemInfoTool.currentScreenSize() == .deviceScreenSize_58{//iPhoheX高度
            return 88
        }else{
            return 64
        }
    }
}
let kStatusBarHeight : CGFloat = 20
