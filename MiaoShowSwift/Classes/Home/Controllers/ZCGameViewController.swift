//
//  ZCGameViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCGameViewController: ZCAnimateNavAndTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.configBlanPage(imageName: "no_follow_250x247", desc: "喵~~这里什么有没有发现") {
            
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
