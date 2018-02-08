//
//  UIView+ZCHud.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//  菊花

import Foundation
import MBProgressHUD

extension UIView{
    
    /// 显示一个普通菊花等待框，界面不可操作
    func showWatting(){
        showWatting(userInteraction: false)
    }
    
    
    /// 显示一个普通菊花等待框,用户决定是否可操作
    ///
    /// - Parameter userInteraction: 是否可操作
    func showWatting(userInteraction:Bool){
        showWatting(userInteraction: userInteraction, delay: Double(MAXFLOAT))
    }
    
    
    /// 显示一个普通菊花等待框,用户决定是否可操作,显示时长
    ///
    /// - Parameters:
    ///   - userInteraction: 是否可操作
    ///   - delay: 时长
    func showWatting(userInteraction:Bool,delay:TimeInterval){
        self.hiddenWatting()
        let hud = MBProgressHUD.init(view: self)
        hud.removeFromSuperViewOnHide = true
        hud.mode = .indeterminate
        hud.isUserInteractionEnabled = userInteraction
        self.addSubview(hud)
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: delay)
    }
    
    func showToast(text:String?){
        showToast(text: text, delay: 3.0)
    }
    
    func showToast(text:String?,delay:TimeInterval){
        self.hiddenWatting()
        if text == nil{
            return
        }
        let hud = MBProgressHUD.init(view: self)
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.label.text = text
        self.addSubview(hud)
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: delay)
    }
    
    
    /// 停止带动画
    func hiddenWatting(){
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    
    /// 立即停止
    func hiddenWaitingImmediately(){
        MBProgressHUD.hide(for: self, animated: false)
    }
    
    
}
