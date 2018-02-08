//
//  ZCLiveToolView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/8.
//  Copyright © 2018年 赵琛. All rights reserved.
//  直播底部工具条

import UIKit


/// 功能
///
/// - talkPublic: 发弹幕
/// - talkPrivate: 私聊
/// - rank: 排行
/// - share: 分享
/// - sendGift: 送礼
/// - close: 关闭
enum LiveToolFuncation {
    case talkPublic
    case talkPrivate
    case rank
    case share
    case sendGift
    case close
}

typealias LiveToolFunctionClickClourse = (_ funcationType:LiveToolFuncation) -> Void

class ZCLiveToolView: UIView {
    
   private let leftImageNames = ["talk_public_40x40","talk_private_40x40","talk_rank_40x40"]
    
    private let rightImageNames = ["talk_close_40x40","talk_sendgift_40x40","talk_share_40x40"]
    
    var functionClickClourse : LiveToolFunctionClickClourse?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    //MARK: Pravite
    
    private func createUI(){
        backgroundColor = UIColor.clear
        
        var leftLastButton : UIButton? = nil
        var rightLastButton : UIButton? = nil
        var i = 0
        //左边按钮
        for imageName in leftImageNames {
            let leftButton = UIButton(type: .custom)
            leftButton.setImage(UIImage(named: imageName), for: .normal)
            leftButton.addTarget(self, action: #selector(functionButtonClick(sender:)), for: .touchUpInside)
            leftButton.tag = i
            addSubview(leftButton)
            leftButton.snp.makeConstraints {
                $0.centerY.equalTo(self)
                $0.size.equalTo(CGSize(width: 40, height: 40))
                if leftLastButton == nil{
                    $0.left.equalTo(self).offset(10)
                }else{
                    $0.left.equalTo(leftLastButton!.snp.right).offset(10)
                }
            }
            leftLastButton = leftButton
            i = i+1
        }
        
        //右边按钮
        
        for imageName in rightImageNames {
            let rightButton = UIButton(type: .custom)
            rightButton.setImage(UIImage(named: imageName), for: .normal)
            rightButton.tag = i
            rightButton.addTarget(self, action: #selector(functionButtonClick(sender:)), for: .touchUpInside)
            addSubview(rightButton)
            rightButton.snp.makeConstraints {
                $0.centerY.equalTo(self)
                $0.size.equalTo(CGSize(width: 40, height: 40))
                if rightLastButton == nil{
                    $0.right.equalTo(self).offset(-10)
                }else{
                    $0.right.equalTo(rightLastButton!.snp.left).offset(-10)
                }
            }
            rightLastButton = rightButton
            i = i+1
        }
        
    }
    
    //MARK: Target
    @objc private func functionButtonClick(sender:UIButton){
        var functionType : LiveToolFuncation = .talkPublic
        if sender.tag == 0{
            functionType = .talkPublic
        }else if sender.tag == 1{
            functionType = .talkPrivate
        }else if sender.tag == 2{
            functionType = .rank
        }else if sender.tag == 3{
            functionType = .close
        }else if sender.tag == 4{
            functionType = .sendGift
        }else{
            functionType = .rank
        }
        
        if functionClickClourse != nil {
            functionClickClourse!(functionType)
        }
        
    }
}
