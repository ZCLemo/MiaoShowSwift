//
//  UIView+ZCEaseBlankPageView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/2.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation

private var blankPageViewKey: UInt8 = 0

extension UIView{
    
    var blankPageView : ZCEaseBlankPageView?{
        get{
            return objc_getAssociatedObject(self, &blankPageViewKey) as? ZCEaseBlankPageView
        }
        set(newValue){
            objc_setAssociatedObject(self, &blankPageViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func configBlanPage(imageName:String,desc:String,clickClourse:()->Void){
        if blankPageView == nil {
            blankPageView = ZCEaseBlankPageView.init(frame: self.bounds)
        }
        blankPageView!.desc = desc
        blankPageView!.imageName = imageName
        addSubview(blankPageView!)
    }
    
}
