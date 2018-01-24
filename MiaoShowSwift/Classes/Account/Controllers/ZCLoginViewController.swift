//
//  ZCLoginViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//  登录页面

import UIKit

class ZCLoginViewController: ZCBaseViewController {

    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUI()
    }
    
    private func createUI(){
        view.addSubview(backgroundImageV)
        backgroundImageV.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        
        view.addSubview(tipLb)
        tipLb.snp.makeConstraints {
            $0.bottom.equalTo(self.view).offset(-150)
            $0.left.right.equalTo(self.view)
        }
    }
    
    //MARK: Lazy
    
    private lazy var backgroundImageV : UIImageView = {
        let backgroundImageV = UIImageView.init(image: UIImage.init(named: "login_background.png"))
        return backgroundImageV
    }()
    
    private lazy var tipLb : UILabel = {
        let tipLb = UILabel()
        tipLb.text = "请使用qq登录，因为只集成了qq登录"
        tipLb.textColor = UIColor.white
        tipLb.textAlignment = .center
        tipLb.font = UIFont.systemFont(ofSize: 15)
        return tipLb
    }()
    
    
}
