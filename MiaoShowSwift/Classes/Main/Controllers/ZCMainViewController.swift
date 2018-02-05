//
//  ZCMainViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMainViewController: UITabBarController {

    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去掉系统背景图
        tabBar.backgroundImage = UIImage()
        // 去掉底部默认灰色线条
        tabBar.shadowImage = UIImage()
        
        tabBar.backgroundColor = UIColor.white

        setUpViewControllers()
        
        tabBar.addSubview(tabBarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        removeSystemItem()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeSystemItem()
    }
    
    //MARK: Pravite
    
    /// 移除系统自动生成tabbar线条等，*****注意：这种重写方式设置一级VC不可以直接设置title，需要通过navigationItem.title来实现****
    private func removeSystemItem(){
        for subView in tabBar.subviews {
            if subView as? ZCTabBarView == nil{
                subView.removeFromSuperview()
            }
        }
    }
    
    private func setUpViewControllers(){

        let homeNav = ZCBaseNavigationViewController(rootViewController: ZCHomeViewController())
        let attentionsNav = ZCBaseNavigationViewController(rootViewController: ZCAttentionViewController())
        let rankNav = ZCBaseNavigationViewController(rootViewController: ZCLiveRankViewController())
        let myNav = ZCBaseNavigationViewController(rootViewController: ZCMyViewController())
        
        viewControllers = [homeNav,attentionsNav,UIViewController(),rankNav,myNav]
    }
    
    //MARK: Lazy
    
    private lazy var tabBarView : ZCTabBarView = {
        let tabBarView = ZCTabBarView.init(frame: tabBar.bounds)
        tabBarView.itemCount = viewControllers!.count
        tabBarView.shouldSelectedClourse = { [weak self]
            (selectedIndex) in
            self?.selectedIndex = selectedIndex
        }
        return tabBarView
    }()
}

