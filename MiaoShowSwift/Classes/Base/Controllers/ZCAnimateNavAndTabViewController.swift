//
//  ZCAnimateNavAndTabViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/31.
//  Copyright © 2018年 赵琛. All rights reserved.
//  滑动时隐藏nav和tab动画基类

import UIKit

class ZCAnimateNavAndTabViewController: ZCBaseViewController {
    
    private var lastY : NSNumber?
    
    private var originY : NSNumber?

    private var navigationBar : UINavigationBar?
    
    private var tabBar : UITabBar?
    
    private var homeTitleView : ZCHomeCategoryTitleView?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if navigationBar == nil || tabBar == nil{
            return
        }
    
        navigationBar!.transform = CGAffineTransform.identity
        tabBar!.transform = CGAffineTransform.identity
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeTitleView = getCurrentHomeTitleView()
        navigationBar = self.navigationController?.navigationBar
        tabBar = self.tabBarController?.tabBar
    }
    
    private func getCurrentHomeTitleView() -> ZCHomeCategoryTitleView?{
        let selectedViewController = self.tabBarController?.selectedViewController
        if selectedViewController == nil {
            return nil
        }
        
        let navViewController = selectedViewController as? ZCBaseNavigationViewController
        if navViewController == nil{
            return nil
        }
        
        if navViewController!.viewControllers.count == 0 {
            return nil
        }
        
        let homeVC = navViewController!.viewControllers[0] as? ZCHomeViewController
        if homeVC == nil {
            return nil
        }
        
        return homeVC!.titleView
    }
    
    //还原
    private func reset(){
        
        if tabBar!.y <= kScreenHeight-kTabbarHeight{
            tabBar!.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        if navigationBar!.y >= kStatusBarHeight{
            navigationBar!.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        if homeTitleView != nil && homeTitleView!.y >= kNavigationBarHeight{
            homeTitleView!.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    //隐藏界限
    private func comleteHidden(){
        
        let maxOffsetY = homeTitleView == nil ? kNavigationBarHeight : kNavigationBarHeight+homeTitleViewHeight
        navigationBar!.transform = CGAffineTransform(translationX: 0, y: -maxOffsetY)
        tabBar!.transform = CGAffineTransform(translationX: 0, y: kTabbarHeight)
        if homeTitleView != nil{
            homeTitleView!.transform = CGAffineTransform(translationX: 0, y: -homeTitleViewHeight - kNavigationBarHeight)
        }
        
    }
    
    private func showOrHidden(scrollView : UIScrollView){
        
        if navigationBar == nil || tabBar == nil{
            return
        }
        let navY = navigationBar!.y
        if navY == kStatusBarHeight || navY == kStatusBarHeight - kNavigationBarHeight {
            return
        }
        //显示隐藏的界限
        if navY > -20 {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.reset()
            })
           
        }else{
            
            UIView.animate(withDuration: 0.1, animations: {
                self.comleteHidden()
            })
            
            if scrollView.contentOffset.y < 0  {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
    }
    

}


//Mark : - UIScrollViewDelegate
extension ZCAnimateNavAndTabViewController : UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        originY = NSNumber.init(value: Float(scrollView.contentOffset.y))
        lastY = NSNumber.init(value: Float(scrollView.contentOffset.y))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if lastY == nil {
            return
        }
        
        if navigationBar == nil || tabBar == nil{
            return
        }
        
        let distance = scrollView.contentOffset.y - CGFloat(lastY!.floatValue)
        if distance >= 0 {

            let minNavExistY = homeTitleView == nil ? (kStatusBarHeight - kNavigationBarHeight) : (kStatusBarHeight - kNavigationBarHeight - homeTitleViewHeight)
            
            if tabBar!.y >= kScreenHeight{
                tabBar!.transform = CGAffineTransform(translationX: 0, y: kTabbarHeight)
            }
            
            if navigationBar!.y <= minNavExistY{
                navigationBar!.transform = CGAffineTransform(translationX: 0, y: minNavExistY)
            }
            
            if homeTitleView != nil && homeTitleView!.y <= -homeTitleViewHeight{
                homeTitleView!.transform = CGAffineTransform(translationX: 0, y: -homeTitleViewHeight - kNavigationBarHeight)
            }

        }else{

            reset()
        }
        
        if originY == nil {
            return
        }
        
        let maxOffsetY = homeTitleView == nil ? kNavigationBarHeight : kNavigationBarHeight+homeTitleViewHeight
        
        if scrollView.contentOffset.y - CGFloat(originY!.floatValue) > maxOffsetY{
            comleteHidden()
        }else if CGFloat(originY!.floatValue) - scrollView.contentOffset.y > maxOffsetY{
            navigationBar!.transform = CGAffineTransform.identity
            tabBar!.transform = CGAffineTransform.identity
            if homeTitleView != nil{
                homeTitleView!.transform = CGAffineTransform.identity
            }
        }else{

            navigationBar!.transform = CGAffineTransform.translatedBy(navigationBar!.transform)(x: 0, y: -distance)
            
            tabBar!.transform = CGAffineTransform.translatedBy(tabBar!.transform)(x: 0, y: distance)

            if homeTitleView != nil{
                homeTitleView!.transform = CGAffineTransform.translatedBy(homeTitleView!.transform)(x: 0, y: -distance)
            }
            
            reset()
            
        }
        
        self.lastY = NSNumber.init(value: Float(scrollView.contentOffset.y))
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        showOrHidden(scrollView: scrollView)
        lastY = nil
        originY = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showOrHidden(scrollView: scrollView)
        lastY = nil
        originY = nil
    }
    
}
