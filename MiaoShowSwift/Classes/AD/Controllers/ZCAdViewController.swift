//
//  ZCAdViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/23.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCAdViewController: ZCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUI()

    }
    
    private func createUI(){
    
        view.addSubview(logImageV)
        logImageV.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        
        view.addSubview(adImageV)
        adImageV.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view)
            $0.height.equalTo(self.view.snp.width).multipliedBy(1.5)
        }
        
        view.addSubview(circleView)
        circleView.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(30)
            $0.right.equalTo(self.view).offset(-30)
            $0.size.equalTo(CGSize(width:50,height:50))
        }
        
    }
    
    
    
    //MARK: Lazy
    
    private lazy var logImageV : UIImageView = {
    
        let logImageV = UIImageView()
        var imageName = ""
        let screenSize = ZCSystemInfoTool.currentScreenSize()
        switch screenSize{
        case .deviceScreenSize_35:
            imageName = "launchImage_640x960"
        case .deviceScreenSize_40:
            imageName = "launchImage_640x1136"
        case .deviceScreenSize_47:
            imageName = "launchImage_750x1334"
        case .deviceScreenSize_55:
            imageName = "launchImage_1242x2208"
        case .deviceScreenSize_58:
            imageName = "launchImage_1242x2208"
        }
        logImageV.image = UIImage.init(named: imageName)
        return logImageV
    }()
    
    private lazy var adImageV : UIImageView = {
        
        let adImageV = UIImageView()
        adImageV.zc_setImage(urlStr: "http://testvip.inleadbank.com.cn/cmsImg/20170914/7248236f-bff7-46c5-91b2-61dc19d270f6.jpg", placeHolderImage: nil)
        return adImageV
    }()
    
    private lazy var circleView : ZCCircleTimerView = {
        let circleView = ZCCircleTimerView()
        return circleView
    }()
    
}
