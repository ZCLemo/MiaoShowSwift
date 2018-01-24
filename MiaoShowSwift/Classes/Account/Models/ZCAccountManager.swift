//
//  ZCAccountManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCAccountManager: NSObject {

    static let manager = ZCAccountManager()
    class func sharedInstance() -> ZCAccountManager{
        return manager
    }
    
    func isLogin() -> Bool{
        return true
    }
    
}
