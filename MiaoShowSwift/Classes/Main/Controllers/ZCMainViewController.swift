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
    }
    
    private func setup(){
        addChildViewControllerWithImageName(childViewController: ZCHomeViewController(), imageName: "toolbar_home")
        addChildViewControllerWithImageName(childViewController: UIViewController(), imageName: "toolbar_live")
        
        addChildViewControllerWithImageName(childViewController: ZCMyViewController(), imageName: "toolbar_me")
        
    }
    
    private func addChildViewControllerWithImageName(childViewController:UIViewController!,imageName:String!){
        let nav = ZCBaseNavigationViewController.init(rootViewController: childViewController)
        childViewController.tabBarItem.image = UIImage.init(named: imageName)
        childViewController.tabBarItem.selectedImage = UIImage.init(named: imageName+"_sel")
        childViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        addChildViewController(nav)
    }

}
