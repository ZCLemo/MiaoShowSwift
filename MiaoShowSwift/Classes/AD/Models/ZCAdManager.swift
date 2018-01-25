//
//  ZCAdManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCAdManager: NSObject {

    //广告是否展示过
    var shownAd : Bool = false
    
    static let manager = ZCAdManager()
    
    class func sharedInstance() -> ZCAdManager{
        return manager
    }
    
    func showAd() -> Bool{
        return !shownAd
    }
    
    
    
}
