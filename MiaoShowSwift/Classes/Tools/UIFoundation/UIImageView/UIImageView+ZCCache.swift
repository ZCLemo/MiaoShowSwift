//
//  UIImageView+ZCCache.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/24.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func zc_setImage(urlStr:String?,placeHolderImage:UIImage?){
        
        kf.setImage(with: urlStr==nil ? nil : URL(string:urlStr!) , placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    func zc_setImage(urlStr:String?,placeHolderImage:UIImage?,completionHandler: CompletionHandler? = nil){
        kf.setImage(with: urlStr==nil ? nil : URL(string:urlStr!) , placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: completionHandler)
    }
    
}
