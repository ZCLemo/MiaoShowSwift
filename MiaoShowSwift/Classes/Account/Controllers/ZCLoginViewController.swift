//
//  ZCLoginViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//  登录页面

import UIKit
import HandyJSON

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
        
        view.addSubview(qqLoginBtn)
        qqLoginBtn.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.bottom.equalTo(self.view).offset(-60)
            $0.size.equalTo(CGSize(width:60,height:60))
        }
    }
    
    @objc private func qqLoginBtnClick(){
        
        view.showWatting()
        let permissions = [kOPEN_PERMISSION_GET_INFO,kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,kOPEN_PERMISSION_GET_INFO]
        tencentOAuth.authorize(permissions)
    }
    
    //MARK: Lazy
    
    private lazy var backgroundImageV : UIImageView = {
        let backgroundImageV = UIImageView.init(image: UIImage.init(named: "login_background"))
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
    
    private lazy var qqLoginBtn : UIButton = {
        let qqLoginBtn = UIButton.init(type: .custom)
        qqLoginBtn.setImage(UIImage.init(named: "login_qq"), for: .normal)
        qqLoginBtn.addTarget(self, action: #selector(qqLoginBtnClick), for: .touchUpInside)
        return qqLoginBtn
    }()
    
    private lazy var tencentOAuth : TencentOAuth = {
        let tencentOAuth = TencentOAuth.init(appId: "1106703376", andDelegate: self)
        return tencentOAuth!
    }()
    
}


// MARK: - TencentSessionDelegate
extension ZCLoginViewController : TencentSessionDelegate{
    func tencentDidLogin() {
        self.tencentOAuth.getUserInfo()
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        self.view.showToast(text: cancelled ? "用户取消登录" : "登录失败")
        
    }
    
    func tencentDidNotNetWork() {
        self.view.showToast(text: "网络异常")
    }
    
    func getUserInfoResponse(_ response: APIResponse!) {
        
        view.hiddenWatting()
        
        if response != nil && response.retCode == Int32(URLREQUEST_SUCCEED.rawValue) {
            
            let userInfo = response.jsonResponse as? [String : Any]
            
            let account = JSONDeserializer<ZCAccount>.deserializeFrom(dict: userInfo)
            if account != nil{
                ZCAccountManager.sharedInstance().saveAccount(account: account!)
                ZCAppControllerManager.sharedInstanced().setUpRoot()
            }
            
        }else{
            print(response.errorMsg)
        }
    }
    
}
