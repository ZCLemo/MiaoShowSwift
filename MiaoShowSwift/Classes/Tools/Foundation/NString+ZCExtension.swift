//
//  NString+ZCExtension.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/5.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation

extension  String {
    
    static func safeStr(_ string: String?) -> String {
        return string ?? ""
    }
    
    // 获取字符串长度
    static func stringSize(_ string: String?, _ font: UIFont, _ maxSize: CGSize) -> CGSize {
        let safeString = String.safeStr(string)
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = safeString.boundingRect(with: maxSize, options: option, attributes: [NSAttributedStringKey.font: font], context: nil)
        return rect.size;
    }
    
}
