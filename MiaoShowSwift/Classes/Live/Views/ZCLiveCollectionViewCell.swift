//
//  ZCLiveCollectionViewCell.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/7.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import IJKMediaFramework
import Alamofire

class ZCLiveCollectionViewCell: UICollectionViewCell {
    
    var livePlayer : IJKFFMoviePlayerController?
    
    weak var parentVC : UIViewController!
  
    private var praiseBirthRate : Float = 1.0
    
    var live = ZCLiveModel() {
        didSet{
            contentView.bringSubview(toFront: placeholdImageView)
            contentView.showWatting()
            dealData()
            createLivePlayer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }

    
    //MARK: Pravite
    
    private func createUI(){
        contentView.addSubview(placeholdImageView)
        placeholdImageView.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
        
        placeholdImageView.addSubview(effectView)
        effectView.snp.makeConstraints {
            $0.edges.equalTo(self.placeholdImageView)
        }
        
        contentView.addSubview(toolView)
        toolView.snp.makeConstraints {
            $0.left.right.equalTo(self.contentView)
            $0.bottom.equalTo(self.contentView).offset(-10)
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(infomationView)
        infomationView.snp.makeConstraints {
            $0.left.equalTo(self.contentView).offset(10)
            $0.top.equalTo(self.contentView).offset(30)
            $0.size.equalTo(CGSize(width: 180, height: 50))
        }
        
        contentView.addSubview(chaoyangUsersView)
        chaoyangUsersView.snp.makeConstraints {
            $0.left.equalTo(self.infomationView.snp.right).offset(10)
            $0.right.equalTo(self.contentView).offset(-10)
            $0.centerY.equalTo(infomationView)
            $0.height.equalTo(40)
        }
        
        contentView.layer.addSublayer(praiseEmitterLayer)
    }
    
    /// 赋值
    private func dealData(){
        placeholdImageView.zc_setImage(urlStr: live.bigpic, placeHolderImage: UIImage(named: "private_icon_70x70_"))
        infomationView.live = live
    }
    
    /// 创建播放器
    private func createLivePlayer(){
        if livePlayer != nil {
            livePlayer!.shutdown()
            livePlayer!.view.removeFromSuperview()
            livePlayer = nil
            NotificationCenter.default.removeObserver(self)
            return
        }
        
        livePlayer = IJKFFMoviePlayerController.init(contentURLString: live.flv, with: options)
        livePlayer!.view.frame = self.contentView.bounds
        // 填充
        livePlayer!.scalingMode = .aspectFill
        //不自动播放
        livePlayer!.shouldAutoplay =  false
        //不自动显示菊花
        livePlayer!.shouldShowHudView = false
        //准备播放
        livePlayer!.prepareToPlay()
        
        contentView.addSubview(livePlayer!.view)
        contentView.sendSubview(toBack: livePlayer!.view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playDidFinish), name: .IJKMPMoviePlayerPlaybackDidFinish, object: livePlayer!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playStateChange), name: .IJKMPMoviePlayerLoadStateDidChange, object: livePlayer!)
    }
    
    //播放中断
    @objc private func playDidFinish(){
        
        if livePlayer!.loadState == [.stalled] {
            contentView.showWatting()
        }
        
        //    方法：
        //      1、重新获取直播地址，服务端控制是否有地址返回。
        //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
        Alamofire.request(live.flv).responseJSON { (response) in
            if response.error != nil{
                self.livePlayer!.shutdown()
                self.livePlayer!.view.removeFromSuperview()
                self.livePlayer = nil
            }
        }
        
    }
    
    /// 状态变化
    @objc private func playStateChange(){
        
        //播放准备就绪，可以播放
        if livePlayer!.loadState == [.playthroughOK,.playable] {
            
            if !livePlayer!.isPlaying(){
                livePlayer!.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.contentView.hiddenWatting()
                    self.contentView.sendSubview(toBack: self.placeholdImageView)
                }
            }else{
                //如果网络不好，后来恢复了，去掉加载动画
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.contentView.hiddenWatting()
                }
            }
            
            return
        }
        
    }
    
    /// 退出
    private func quit(){
        if livePlayer != nil {
            livePlayer!.shutdown()
            livePlayer!.view.removeFromSuperview()
            livePlayer = nil
        }
        
        self.parentVC.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Lazy
    
    private lazy var placeholdImageView : UIImageView = {
        let placeholdImageView = UIImageView()
        return placeholdImageView
    }()
    
    //毛玻璃
    private lazy var effectView : UIVisualEffectView = {
        let buffEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView.init(effect: buffEffect)
        return blurView
    }()
    
    //直播设置
    private lazy var options : IJKFFOptions = {
        let options = IJKFFOptions.byDefault()
        //开启硬件解码
        options!.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
        options!.setPlayerOptionIntValue(15, forKey: "r")
        //        -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
        options!.setPlayerOptionIntValue(256, forKey: "vol")
        // 最大fps
        options!.setPlayerOptionIntValue(30, forKey: "max-fps")
        
        // 跳帧开关，如果cpu解码能力不足，可以设置成5，否则会引起音视频不同步，也可以通过设置它来跳帧达到倍速播放
        //options!.setPlayerOptionIntValue(0, forKey: "framedrop")
        
        //指定最大宽度
        //options!.setPlayerOptionIntValue(960, forKey: "videotoolbox-max-frame-width")
        
        //自动转屏开关
        //options!.setFormatOptionIntValue(0, forKey: "auto_convert")
        
        //重连次数
        //options!.setFormatOptionIntValue(3, forKey: "reconnect")
        
        //超时时间
//        options!.setFormatOptionIntValue(30*1000*1000, forKey: "timeout")

        return options!
    }()
    
    //底部工具条
    private lazy var toolView : ZCLiveToolView = {
        
        let toolView = ZCLiveToolView()
        toolView.functionClickClourse = { [weak self] (functionType) in
            if functionType == .close{
                self?.quit()
            }
        }
        return toolView
    }()
    
    
    /// 顶部主播信息
    private lazy var infomationView : ZCLiveInfomationView = {
        let infomationView = ZCLiveInfomationView()
        infomationView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        infomationView.layer.cornerRadius = 25
        infomationView.clipsToBounds = true
        return infomationView
    }()
    
    
    /// 朝阳观众
    private lazy var chaoyangUsersView : ZCChaoyangUsersView = {
        let chaoyangUsersView = ZCChaoyangUsersView()
        return chaoyangUsersView
    }()
    
    //粒子动画
    private lazy var praiseEmitterLayer : ZCPraiseEmitterLayer = {
        let praiseEmitterLayer = ZCPraiseEmitterLayer()
        praiseEmitterLayer.emitterPosition = CGPoint(x: kScreenWidth-50, y: kScreenHeight-50)
        return praiseEmitterLayer
    }()
}

//Mark - touchesBegan 点击加速

extension ZCLiveCollectionViewCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        praiseBirthRate = praiseBirthRate + 1.0
        if praiseBirthRate > 5.0 {
            praiseBirthRate = 5.0
        }
        praiseEmitterLayer.birthRate = praiseBirthRate
        //过0.5速度衰减一次
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.praiseBirthRate = self.praiseBirthRate - 1.0
            if self.praiseBirthRate < 1.0{
                self.praiseBirthRate = 1.0
            }
            self.praiseEmitterLayer.birthRate = self.praiseBirthRate
        }
    }
    
}


