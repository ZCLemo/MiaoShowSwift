//
//  ZCBaseResponseModel.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/29.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import HandyJSON

class ZCBaseResponseModel<T : HandyJSON>: HandyJSON {

    var code : String = ""
    var msg : String = ""
    var data : T = T()
    
    required init(){}
    
}

//MARK: Public
extension ZCBaseResponseModel{
    func success() -> Bool{
        return code == "100"
    }
}
