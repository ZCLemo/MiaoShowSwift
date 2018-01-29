//
//  UIView+ZCFrame.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation

extension UIView{
    
    var x : CGFloat {
        get{
            return self.frame.origin.x
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y : CGFloat{
        
        get{
            return self.frame.origin.y
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
    }
    
    var h :CGFloat{
        get{
            return self.frame.size.height
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    
    var w :CGFloat{
        get{
            return self.frame.size.width
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    
}
