//
//  ZCLiveRankViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import WebKit

class ZCLiveRankViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    private lazy var webView : WKWebView = {
        let webView = WKWebView()
        let request = URLRequest(url: URL(string: "http://live.9158.com/Rank/WeekRank")!)
        webView.load(request)
        return webView
    }()
}
