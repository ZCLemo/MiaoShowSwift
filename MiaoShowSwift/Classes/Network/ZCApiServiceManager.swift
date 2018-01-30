//
//  ZCApiServiceManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/29.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import Moya
import HandyJSON

/// post请求参数
var apiRequestPatameters = [String : Any]()

/// 请求编号
var clientNO : Int = 0

class ZCApiServiceManager<Target : TargetType> {

    var apiService : MoyaProvider<ZCApiService>!
    
    init(){
        let currentClientNO = getClientNO()
        apiService = MoyaProvider<ZCApiService>(plugins:[NetworkLoggerPlugin.init(verbose: true, cURL: false, output: nil, requestDataFormatter: { (data) in
            return NetworkLoggerPlugin.requestDataFormmatter(requestPatameters: apiRequestPatameters,clientNO:  currentClientNO)
            
        }, responseDataFormatter: {
            (data) in
            return NetworkLoggerPlugin.responseDataFormmatter(responseData: data,clientNO: currentClientNO)
        })])
        
    }
    
    
    /// 给每个请求加一个ID用来标识
    ///
    /// - Returns: ID
    private func getClientNO() -> Int{
        clientNO = clientNO+1
        return clientNO
    }
    
    /// 发送请求
    ///
    /// - Parameters:
    ///   - target: service
    ///   - model: 需要序列化的对象
    ///   - completion: 完成闭包
    /// - Returns: Cancellable
    func request<T: HandyJSON>(_ target : Target,model: T.Type,completion:((_ success:Bool, _ errorDesc:String?, _ data: T?) -> Void)?) -> Cancellable?{
        
        return apiService.request(target as! ZCApiService, completion: { (result) in
            
            guard let completion = completion else{return}
            
            if result.error != nil{
                let errorDesc = result.error!.errorDescription
                completion(false,errorDesc,nil)
                return
            }
            
            guard let data = try? result.value?.mapModel(_type: ZCBaseResponseModel<T>.self) else{
                completion(false,"数据解析错误",nil)
                return
            }

            if data!.success(){
                completion(true,nil,data!.data)
            }else{
                completion(false,data!.msg,nil)
            }
        })
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_type: T.Type) throws -> T{
        
        let jsonString = String(data: data, encoding: .utf8)
        
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
        
    }
}
