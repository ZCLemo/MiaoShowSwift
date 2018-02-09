//
//  ZCPraiseEmitterLayer.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/9.
//  Copyright © 2018年 赵琛. All rights reserved.
//  点赞粒子效果

import UIKit

class ZCPraiseEmitterLayer: CAEmitterLayer {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        emitterSize = CGSize(width: 20, height: 20)
        renderMode =  kCAEmitterLayerUnordered
        birthRate = 1.0
        var cells = [CAEmitterCell]()
        for i in 1 ..< 10 {
            let emitterCell = CAEmitterCell()
            //粒子创建速率
            emitterCell.birthRate = 0.5
            //粒子存活时间
            emitterCell.lifetime = Float(arc4random_uniform(3)+1)
            //粒子的生存时间容差
            emitterCell.lifetimeRange = 1
            
            emitterCell.contents = UIImage(named: "good"+String(i))?.cgImage
            
            //粒子的运动速度
            emitterCell.velocity = CGFloat(arc4random_uniform(60) + 60)
            //粒子速度容差
            emitterCell.velocityRange = 60
            //粒子在xy平面的发射角度
            emitterCell.emissionLongitude = CGFloat(Double.pi/2.0*3.0)
            // 粒子发射角度的容差
            emitterCell.emissionRange = CGFloat(Double.pi/12.0)
            //缩放比例
            emitterCell.scale = 0.7;
            
            cells.append(emitterCell)
        }
        
        emitterCells = cells
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
}
