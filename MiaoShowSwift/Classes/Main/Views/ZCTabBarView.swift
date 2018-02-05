//
//  ZCTabBarView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/5.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

typealias ZCTabBarViewShouldSelectedClourse = (_ selectedIndex : Int) -> Void

class ZCTabBarView: UIView {
    
    var itemCount = 0 {
        didSet{
            createUI()
        }
    }
    
    var selectedIndex = 0 {
        didSet{
            changeSelectedIndex()
        }
    }
    
    let itemBtnTag = 1000
    
    var imageNames = ["toolbar_home","toolbar_follow","toolbar_live","toolbar_rank","toolbar_me"]
    
    var titles = ["广场","关注","","排行","我的"]
    
    var shouldSelectedClourse : ZCTabBarViewShouldSelectedClourse?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    //MARK: Pravite
    
    /// 改变选中状态
    private func changeSelectedIndex(){
        for subView in subviews {
            if  subView as? ZCTabBarItemButton != nil{
                 let itemBtn = subView as! ZCTabBarItemButton
                 itemBtn.isSelected = (itemBtn.tag-itemBtnTag == selectedIndex)
            }
        }
    }
    
    /// 选中动画
    private func animationItem(tag : Int){
        let itemBtn = viewWithTag(tag) as! ZCTabBarItemButton
        itemBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20.0, options: .allowUserInteraction, animations: {
            itemBtn.itemIcon.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (result) in
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20.0, options: .allowUserInteraction, animations: {
                itemBtn.itemIcon.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: { (result) in
                itemBtn.isUserInteractionEnabled = true
            })
            
        }
    }
    
    //MARK: Target
    
    @objc private func btnClick(sender:ZCTabBarItemButton){
        
        animationItem(tag: sender.tag)
        
        if shouldSelectedClourse != nil{
            shouldSelectedClourse!(sender.tag - itemBtnTag)
        }
        
        if selectedIndex == sender.tag - itemBtnTag || (sender.tag - itemBtnTag == 2){
            return
        }
        
        selectedIndex = sender.tag - itemBtnTag
        changeSelectedIndex()
    }
    
    //MARK: Lazy
    
    private func createUI(){
        
        var lastItemBtn : ZCTabBarItemButton? = nil
        for i in 0..<itemCount{
            let itemBtn = ZCTabBarItemButton(type: .custom)
            itemBtn.imageName = imageNames[i]
            itemBtn.itemTitle = titles[i]
            itemBtn.selectedImageName = imageNames[i] + "_sel"
            itemBtn.isSelected = (i == selectedIndex)
            itemBtn.tag = itemBtnTag + i
            itemBtn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            addSubview(itemBtn)
            itemBtn.snp.makeConstraints({
                $0.top.bottom.equalTo(self)
                if lastItemBtn == nil{
                    $0.left.equalTo(self)
                }else{
                      $0.left.equalTo(lastItemBtn!.snp.right)
                }
                $0.width.equalTo(self.snp.width).dividedBy(itemCount)
            })
            lastItemBtn = itemBtn
        }
    }
    
}
