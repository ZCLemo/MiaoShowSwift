//
//  ZCHomeCategoryTitleView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//  顶部分类

import UIKit

typealias ZCHomeCategoryTitleViewClickClosure = (_ selectedIndex:Int) -> Void

class ZCHomeCategoryTitleView: UIView {

    var titles : [String]?
    
    var selectedIndex = 0{
        didSet{
            changeSelectedIndex()
        }
    }
    
    var titleViewClickClosure : ZCHomeCategoryTitleViewClickClosure?
    
    private var normalColor : UIColor?
    
    private var selectedColor : UIColor?
    
    private var textFont : UIFont?
    
    private var selectedTextFont : UIFont?
    
    private var titieBtnTag = 1000
    
    init(titles:[String]?){
        super.init(frame: .zero)
        
        backgroundColor = UIColor.white
        
        normalColor = UIColor.lightGray
        selectedColor = UIColor.red
        textFont = UIFont.systemFont(ofSize: 15)
        selectedTextFont = UIFont.systemFont(ofSize: 15)
        self.titles = titles
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Pravite
    
    private func createUI(){
        
        if titles == nil{
            return;
        }
        
        if titles!.count == 0 {
            return
        }
        
        //记录上一个titleBtn
        var lastTitleBtn : UIButton? = nil
        var i = 0
        for title in titles! {
            let titleBtn = UIButton.init(type: .custom)
            titleBtn.setTitle(title, for: .normal)
            titleBtn.setTitleColor(normalColor, for: .normal)
            titleBtn.setTitleColor(selectedColor, for: .selected)
            titleBtn.titleLabel?.font = textFont
            titleBtn.isSelected = (i==0)
            titleBtn.tag = titieBtnTag + i
            titleBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
            addSubview(titleBtn)
            titleBtn.snp.makeConstraints{
                $0.top.bottom.equalTo(self)
                $0.width.equalTo(self.snp.width).dividedBy(self.titles!.count)
                if lastTitleBtn == nil{
                    $0.left.equalTo(self)
                }else{
                    $0.left.equalTo(lastTitleBtn!.snp.right)
                }
            }
            
            lastTitleBtn = titleBtn
            i = i+1
        }
    
        addSubview(slider)
        let titleBtn = viewWithTag(titieBtnTag) as! UIButton
        slider.snp.makeConstraints {
            $0.centerX.equalTo(titleBtn)
            $0.bottom.equalTo(self)
            $0.size.equalTo(CGSize(width:50,height:2))
        }
        
        
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self)
            $0.height.equalTo(0.5)
        }
    }
    
    
    /// 改变选中的title
    private func changeSelectedIndex(){
        let titleBtn = viewWithTag(titieBtnTag + selectedIndex) as! UIButton
        slider.snp.remakeConstraints {
            $0.centerX.equalTo(titleBtn)
            $0.bottom.equalTo(self)
            $0.size.equalTo(CGSize(width:50,height:2))
        }
        
        for subView in self.subviews {
            if subView as? UIButton != nil{
                let subTitleBtn = subView as! UIButton
                subTitleBtn.isSelected = (selectedIndex+titieBtnTag==subTitleBtn.tag)
            }
        }
    }
    
    //MARK: Target
    
    /// title点击
    @objc private func titleBtnClick(sender:UIButton){
        if sender.tag == titieBtnTag+selectedIndex {
            return
        }
        
        if titleViewClickClosure != nil {
            titleViewClickClosure!(sender.tag - titieBtnTag)
        }
    }
    
    //MARK: Lazy
    
    /// 滑块
    private lazy var slider : UIView = {
        let slider = UIView()
        slider.backgroundColor = UIColor.red
        return slider
    }()
    
    
    /// 分割线
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        return lineView
    }()
}

// MARK: - 对外暴露的方法
extension ZCHomeCategoryTitleView{
    
    func sliderMoveWithOffset(offset:CGFloat){
        slider.x = (self.w/CGFloat(titles!.count)-slider.w)/CGFloat(2) + offset*self.w/CGFloat(titles!.count)
    }
}
