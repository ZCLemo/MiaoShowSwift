//
//  ZCChaoyangUsersView.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/8.
//  Copyright © 2018年 赵琛. All rights reserved.
//  朝阳观众

import UIKit
import HandyJSON

class ZCChaoyangUsersView: UIView {
    
    var users : [ZCChaoyangUser]!
    
    private let space : CGFloat = 10
    
    private let avaterWH : CGFloat = 40
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let path = Bundle.main.path(forResource: "user.plist", ofType: "")
        let array = NSArray.init(contentsOfFile: path!)
        users =  JSONDeserializer<ZCChaoyangUser>.deserializeModelArrayFrom(array: array) as! [ZCChaoyangUser]
        createUI()
    }
    
    //MARK: Pravite
    private func createUI(){
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        for i in 0 ..< users.count {
            let user = users[i]
            let avater = UIImageView()
            avater.zc_setImage(urlStr: user.photo, placeHolderImage: nil)
            avater.layer.cornerRadius = avaterWH/2.0
            avater.clipsToBounds = true
            scrollView.addSubview(avater)
            avater.snp.makeConstraints {
                $0.left.equalTo(scrollView).offset(CGFloat(i)*(avaterWH+space))
                $0.centerY.equalTo(scrollView)
                $0.size.equalTo(CGSize(width: avaterWH, height: avaterWH))
            }
        }
    }
    
    //MARK: Lazy
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: CGFloat(users.count) * avaterWH + CGFloat(users.count-1) * space, height: 0)
        return scrollView
    }()
    
}
