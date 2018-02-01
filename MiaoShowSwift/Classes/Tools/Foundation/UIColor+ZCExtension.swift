//
//  UIColor+ZCExtension.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/30.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    
    /// rgb
    ///
    /// - Parameters:
    ///   - red: 红色色值
    ///   - green: 绿色色值
    ///   - blue: 蓝色色值
    /// - Returns: 颜色
    class func  rgbColor(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor{
        
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    
    /// rgba
    ///
    /// - Parameters:
    ///   - red: 红色色值
    ///   - green: 绿色色值
    ///   - blue: 蓝色色值
    ///   - alpha: 透明度
    /// - Returns: 颜色
    class func rgbaColor(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
        
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    
    /// 16进制转颜色
    ///
    /// - Parameter hexValue: 16进制数值
    /// - Returns: 颜色
    class func colorFormHex(hexValue:Int) -> UIColor{
        
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
}
