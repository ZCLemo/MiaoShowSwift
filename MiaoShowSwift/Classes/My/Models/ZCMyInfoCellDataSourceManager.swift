//
//  ZCMyInfoCellDataSourceManager.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/6.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMyInfoCellDataSourceManager {
    
    private static let manager = ZCMyInfoCellDataSourceManager()
    
    class func shareInstanced() -> ZCMyInfoCellDataSourceManager {
        return manager
    }
    
    func dataSource() -> [[ZCMyInfoCellModel]]!{
        var dataSource = [[ZCMyInfoCellModel]]()
        
        let group1 = [ZCMyInfoCellModel(title: "我的喵币", iconName: "my_coin", text: "100枚", imageName: "", titleColor: UIColor.black, textColor: UIColor.orange, cellType: .text),
                       ZCMyInfoCellModel(title: "直播间管理", iconName: "live_manager", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
                       ZCMyInfoCellModel(title: "我的短视频", iconName: "shortVideo", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
                       ZCMyInfoCellModel(title: "号外!做任务赢礼包~", iconName: "box", text: "", imageName: "task_normal_gold", titleColor: UIColor.orange, textColor: UIColor.white, cellType: .image)
        ]
        
        let group2 = [ZCMyInfoCellModel(title: "我的收益", iconName: "income", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
                      ZCMyInfoCellModel(title: "游戏中心", iconName: "game_center", text: "海底派送季，喵币大放送", imageName: "game_center", titleColor: UIColor.black, textColor: UIColor.black, cellType: .textAndImage)
        ]
        
        let group3 = [ZCMyInfoCellModel(title: "联系客服", iconName: "customer_server", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
                      ZCMyInfoCellModel(title: "意见反馈", iconName: "opinion", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
                      ZCMyInfoCellModel(title: "我的设置", iconName: "setting", text: "", imageName: "", titleColor: UIColor.black, textColor: UIColor.white, cellType: .none),
        ]
        
        dataSource = [group1,group2,group3]
        
        return dataSource
    }
}
