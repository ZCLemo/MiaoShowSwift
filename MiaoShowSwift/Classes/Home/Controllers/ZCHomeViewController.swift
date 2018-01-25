//
//  ZCHomeViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCHomeViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.blue
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ZCAccountManager.sharedInstance().removeAccount()
    }

}
