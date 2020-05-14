//
//  UIScrollView+ZCRefresh.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/30.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

typealias RefreshClourse = () -> Void

extension UIScrollView{
    
    /// 下拉刷新
    ///
    /// - Parameter clourse: 回调
    func headerRefresh(clourse:@escaping RefreshClourse){
        let header = MJRefreshGifHeader.init {
            clourse()
        }
        settingHeaderRefresh(header: header)
        mj_header = header
    }
    
    
    /// 上拉加载
    ///
    /// - Parameter clourse: 回调
    func footerRefresh(clourse:@escaping RefreshClourse){
        let footer = MJRefreshAutoGifFooter.init {
            clourse()
        }
        settingFooterRefresh(footer: footer)
        mj_footer = footer
    }
    
    
    /// 结束刷新
    func endRefresh(){
        if mj_header != nil {
            mj_header?.endRefreshing()
        }
        if mj_footer != nil {
            mj_footer?.endRefreshing()
        }
        
    }
    
    
    /// 自动刷新
    func beginHeaderRefreshing(){
        if mj_header != nil {
            mj_header?.beginRefreshing()
        }
    }
    
    
    /// 加载到最后一页
    func refreshNoMore(){
        if mj_footer != nil {
            mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
    
    /// 是否隐藏头部
    ///
    /// - Parameter isHidden:
    func headerHidden(isHidden:Bool){
        if mj_header != nil {
            mj_header?.isHidden = isHidden
        }
    }
    
    
    /// 是否隐藏底部
    ///
    /// - Parameter isHidden: 
    func footerHidden(isHidden:Bool){
        if mj_footer != nil {
            mj_footer?.isHidden = isHidden
        }
    }
    
    //MARK: Pravite
    
    private func settingHeaderRefresh(header:MJRefreshGifHeader?){
        
        if header == nil{
            return
        }
        
        header!.lastUpdatedTimeLabel?.isHidden = true
        header!.stateLabel?.isHidden = true
        header!.setImages([UIImage(named: "reflesh1_60x55") as Any], for: .pulling)
        header!.setImages([
            UIImage(named: "reflesh1_60x55") as Any,
            UIImage(named: "reflesh2_60x55") as Any,
            UIImage(named: "reflesh3_60x55") as Any,
                   ], for: .refreshing)
        header!.setImages([UIImage(named: "reflesh3_60x55") as Any], for: .idle)
        
    }
    
    private func settingFooterRefresh(footer:MJRefreshAutoGifFooter?){
        if footer == nil{
            return
        }
        
        footer!.stateLabel?.isHidden = true
    }
}
