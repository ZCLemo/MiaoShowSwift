//
//  ZCMainViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        tabBar.tintColor = UIColor.rgbColor(red: 254, green: 95, blue: 154)
    }
    
    private func setup(){
        addChildViewControllerWithImageName(childViewController: ZCHomeViewController(), imageName: "toolbar_home",title: "广场")
        
           addChildViewControllerWithImageName(childViewController: ZCAttentionViewController(), imageName: "toolbar_follow",title: "关注")
        addChildViewControllerWithImageName(childViewController: UIViewController(), imageName: "toolbar_live",title: "")
        
        addChildViewControllerWithImageName(childViewController: ZCLiveRankViewController(), imageName: "toolbar_rank",title: "排行")
        
        addChildViewControllerWithImageName(childViewController: ZCMyViewController(), imageName: "toolbar_me",title: "我的")
        
    }
    
    private func addChildViewControllerWithImageName(childViewController:UIViewController!,imageName:String!,title:String!){
        let nav = ZCBaseNavigationViewController(rootViewController: childViewController)
        childViewController.tabBarItem.image = UIImage(named: imageName)
        childViewController.tabBarItem.title = title
        childViewController.tabBarItem.selectedImage = UIImage.init(named: imageName+"_sel")
        if title.count == 0 {
            childViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(nav)
    }

}
