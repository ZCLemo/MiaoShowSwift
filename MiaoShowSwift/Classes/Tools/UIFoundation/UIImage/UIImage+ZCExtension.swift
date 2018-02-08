//
//  UIImage+ZCExtension.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/7.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import Foundation

extension UIImage {
    
    
    /// 高斯模糊
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - blur: 值
    class func blurImage(image:UIImage?,blur:Double) -> UIImage{
        if image == nil {
            return UIImage()
        }
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)

        filter.setValue(blur, forKey: kCIInputRadiusKey)
        
        let outputCIImage = filter.outputImage!
        let rect = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        return UIImage(cgImage: cgImage!)
    }
    
}
