//
//  NetworkLoggerPlugin+Extension.swift
//  SwiftBegin
//
//  Created by 赵琛 on 2017/12/28.
//  Copyright © 2017年 赵琛. All rights reserved.
//

import Foundation
import Moya

extension NetworkLoggerPlugin{
    
    /// 格式化请求日志
    ///
    /// - Parameter requestPatameters: 请求参数
    /// - Returns: 格式化后的字符串
    class func requestDataFormmatter(requestPatameters:[String : Any],clientNO:Int) -> String{
        
        guard let pData = try? JSONSerialization.data(withJSONObject: requestPatameters, options:.prettyPrinted) else{
            return ""
        }
        
        guard let jsonString = String(data: pData, encoding: .utf8) else {
            return ""
        }
        
        var formmatterString = ""
        formmatterString = formmatterString + "\n---------------------------------------------\n"
        formmatterString = formmatterString + "请求参数[\(clientNO)]："
        formmatterString = formmatterString+jsonString
        formmatterString = formmatterString + "\n---------------------------------------------\n"
        return formmatterString
    }
    
    /// 格式化响应数据
    ///
    /// - Parameter responsetData: 响应data
    /// - Returns: 格式化后的data
    class func responseDataFormmatter(responseData:Data,clientNO:Int) -> Data{
        
        guard let jsonString = String(data: responseData, encoding: .utf8) else{
            return responseData
        }
        
        var formmatterString = ""
        formmatterString = formmatterString + "\n---------------------------------------------\n"
        formmatterString = formmatterString + "响应数据[\(clientNO)]："
        formmatterString = formmatterString+jsonString
        formmatterString = formmatterString + "\n---------------------------------------------\n"
        
        guard let data = formmatterString.data(using: .utf8) else{
            return responseData
        }
        
        return data
    }
        
}
