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
        
        guard let urlStr = urlStr else {
            return
        }
        
        guard let url = URL(string:urlStr) else {
            return
        }
        
        kf.setImage(with: url, placeholder: placeHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
