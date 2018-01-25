//
//  AppDelegate.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        ZCAppControllerManager.sharedInstanced().setUpRoot()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
     
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
     
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
   
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
  
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return TencentOAuth.handleOpen(url)
    }

    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return TencentOAuth.handleOpen(url)
    }

}

