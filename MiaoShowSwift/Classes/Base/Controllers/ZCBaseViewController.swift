//
//  ZCBaseViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.rgbColor(red: 254, green: 95, blue: 154)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
}
