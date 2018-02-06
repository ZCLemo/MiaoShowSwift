//
//  ZCAccountManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCAccountManager: NSObject {

    private let accountKey = "accountKey"
    
    static let manager = ZCAccountManager()
    class func sharedInstance() -> ZCAccountManager{
        return manager
    }
    
    /// 本地保存账户信息
    ///
    /// - Parameter account: 账户
    func saveAccount(account:ZCAccount){
        if let encoded = try? JSONEncoder().encode(account){
            UserDefaults.standard.set(encoded, forKey: accountKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// 获取保存本地的账户信息
    ///
    /// - Returns: 账户信息
    func getAccount() -> ZCAccount?{
        let encode = UserDefaults.standard.object(forKey: accountKey)
        if  encode == nil || (encode as? Data == nil){
            return nil
        }
        if let account = try? JSONDecoder().decode(ZCAccount.self, from: encode as! Data){
            return account
        }
        return nil
        
    }
    
    
    /// 判断是否登录
    ///
    /// - Returns: true/false
    func isLogin() -> Bool{
        if ZCAccountManager.sharedInstance().getAccount() != nil{
            return true
        }
        
        return false
    }
    
    
    /// 删除本地保存账号
    func removeAccount(){
        UserDefaults.standard.removeObject(forKey: accountKey)
        UserDefaults.standard.synchronize()
    }
}
