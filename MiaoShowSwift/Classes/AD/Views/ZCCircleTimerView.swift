//
//  ZCCircleTimerView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/24.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCCircleTimerView: UIView {
    
    let  maxCount : Int = 100
    
    var minCount : Int = 0
    
    var duration : Double = 3

    var timeInterval : TimeInterval = 0
    
    deinit {
        timer.invalidate()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeInterval = duration/Double(maxCount)
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(skipBtn)
        skipBtn.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        timer.fire()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pi  = Double.pi
        //线宽度
        let lineWidth: CGFloat = 2.0
        //半径
        let radius = rect.width / 2.0 - lineWidth
        //中心点x
        let centerX = rect.midX
        //中心点y
        let centerY = rect.midY
        //弧度起点
        let startAngle = minCount==maxCount ? CGFloat(-pi/2) : CGFloat(pi/2*3 - pi*2/Double(maxCount) * Double(minCount))
      
        //弧度终点
        let endAngle  = CGFloat(-pi/2)
        
        //创建一个画布
        let context = UIGraphicsGetCurrentContext()
        
        //画笔颜色
        context!.setStrokeColor(UIColor.white.cgColor)
        
        //画笔宽度
        context!.setLineWidth(lineWidth)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        context?.addArc(center: CGPoint(x:centerX,y:centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //绘制路径
        context!.strokePath()
        
    }
    
    /// 开始倒计时
    @objc func timerStart(){
        
        if minCount == maxCount {
            timer.invalidate()
            ZCAppControllerManager.sharedInstanced().setUpRoot()
            return
        }
        
        minCount = minCount+1
        setNeedsDisplay()
    }
    
    
    /// 手动跳转
    @objc func skipBtnClick(){
        timer.invalidate()
        ZCAppControllerManager.sharedInstanced().setUpRoot()
    }
    
    //MARK: Lazy
    private lazy var skipBtn : UIButton = {
        let skipBtn = UIButton.init(type: .custom)
        skipBtn.setTitle("跳过", for: .normal)
        skipBtn.setTitleColor(UIColor.white, for: .normal)
        skipBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        skipBtn.addTarget(self, action: #selector(skipBtnClick), for: .touchUpInside)
        return skipBtn
    }()
    
    private lazy var timer : Timer = {
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        return timer
    }()
    
}
