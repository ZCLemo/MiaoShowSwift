//
//  ZCSystemInfoTool.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/24.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit


/// 屏幕尺寸
///
/// - deviceScreenSize_35: 3.5
/// - deviceScreenSize_40: 4.0
/// - deviceScreenSize_47: 4.7
/// - deviceScreenSize_55: 5.5
/// - deviceScreenSize_58: 5.8
enum  ZCDeviceScreenSize{
    case deviceScreenSize_35
    case deviceScreenSize_40
    case deviceScreenSize_47
    case deviceScreenSize_55
    case deviceScreenSize_58
}

class ZCSystemInfoTool {
    
    class func currentScreenSize() -> ZCDeviceScreenSize{
        let screenH = UIScreen.main.bounds.size.height
        if screenH == 480 {
            return .deviceScreenSize_35
        }else if screenH == 568{
            return .deviceScreenSize_40
        }else if screenH == 667{
            return .deviceScreenSize_47
        }else if screenH == 736{
            return .deviceScreenSize_55
        }else{
            return .deviceScreenSize_58
        }
    }

}
