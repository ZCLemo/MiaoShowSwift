//
//  ZCLiveViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/7.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCLiveViewController: ZCBaseViewController {
    
    //循环，第一页加最后一个主播，最后一页加第一个主播
    var loopLiveList = [ZCLiveModel]()
    
    var liveList = [ZCLiveModel]() {
        didSet{
            loopLiveList.removeAll()
            if liveList.count > 1 { //多余一个主播才循环
                loopLiveList.append(liveList.last!)
                loopLiveList += liveList
                loopLiveList.append(liveList.first!)
            }else{
                loopLiveList += liveList
            }
        }
    }
    
    var currentIndex = 0
    
    let liveCollectionViewCellId = "liveCollectionViewCellId"

    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        
    }
    
    
    //MARK: Pravite
    private func createUI(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        
    }
    
    //MARK: Lazy
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = view.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZCLiveCollectionViewCell.self, forCellWithReuseIdentifier: liveCollectionViewCellId)
        collectionView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentSize = CGSize(width: view.w, height: view.h * CGFloat(loopLiveList.count))
        collectionView.setContentOffset(CGPoint(x: 0, y: CGFloat(liveList.count>1 ? currentIndex+1 : currentIndex) * view.h), animated: false)
        if #available(iOS 11.0, *){
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        return collectionView
    }()
    
}

extension ZCLiveViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.loopLiveList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCollectionViewCellId, for: indexPath) as! ZCLiveCollectionViewCell
        cell.live = self.loopLiveList[indexPath.row]
        cell.parentVC = self
        return cell
    }
    
}


// MARK: - UIScrollViewDelegate
extension ZCLiveViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if liveList.count <= 1 {
            return
        }
        
        //无线循环
        var index = 0
        let count = liveList.count
        var contentOffset = scrollView.contentOffset
        
        print(contentOffset.y/view.h)
        
        if contentOffset.y/view.h > CGFloat(count){//最后一页
            index = 0
            contentOffset.y = 0
            scrollView.contentOffset = contentOffset
        }else if contentOffset.y/view.h < 0.0 {//第一页
            index = count-1
            contentOffset.y = CGFloat(index) * view.h
            scrollView.contentOffset = contentOffset
        }else{
            index = Int(contentOffset.y/view.h)
        }
        
    }
    
}
