//
//  ZCAppControllerManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCAppControllerManager {

    private static let manager = ZCAppControllerManager()
    class  func sharedInstanced() -> ZCAppControllerManager {
        return manager
    }
    
    /// 设置根控制器
    func setUpRoot(){
        if ZCAdManager.sharedInstance().showAd() {
            ZCAdManager.sharedInstance().shownAd = true
            setUpAd()
        }else if !ZCAccountManager.sharedInstance().isLogin(){
            setUpLogin()
        }else{
            setUpMain()
        }
        
//        setUpMain()
    }
    
    
    /// 加载广告
    private func setUpAd(){
        let adVC = ZCAdViewController()
        keyWindow().rootViewController = adVC
        keyWindow().makeKeyAndVisible()
    }
    
    
    /// 加载登录
    private func setUpLogin(){
        let loginVC = ZCLoginViewController()
        keyWindow().rootViewController = loginVC
        keyWindow().makeKeyAndVisible()
    }
    
    
    /// 加载主页
    private func setUpMain(){
        let mainVC = ZCMainViewController()
        keyWindow().rootViewController = mainVC
        keyWindow().makeKeyAndVisible()
    }
    
    private func keyWindow() -> UIWindow{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!
    }
    

}
