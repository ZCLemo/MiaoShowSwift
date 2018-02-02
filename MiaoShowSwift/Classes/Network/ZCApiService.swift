//
//  ZCApiService.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/29.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import Moya


enum ZCApiService {
    case hotLive(page:Int)
    case getAD
    case newestLive(page:Int)
}

extension ZCApiService : TargetType{
    var baseURL: URL {
        return URL.init(string: "http://live.9158.com/")!
    }
    
    var path: String {
        switch self {
        case .hotLive:
            return "Fans/GetHotLive"
            
        case .getAD:
            return "Living/GetAD"
            
        case .newestLive:
            return "Room/GetNewRoomOnline"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        
        var parmeters : [String : Any] = [:]
        switch self {
        case .hotLive(let page):
            parmeters["page"] = page
            
        case .getAD:
            break
            
        case .newestLive(let page) :
            parmeters["page"] = page
        }

        apiRequestPatameters = parmeters
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}


