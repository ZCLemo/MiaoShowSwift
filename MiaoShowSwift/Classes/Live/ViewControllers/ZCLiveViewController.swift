//
//  ZCLiveViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/2/7.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCLiveViewController: ZCBaseViewController {
    
    var liveList = [ZCLiveModel]()
    
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
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZCLiveCollectionViewCell.self, forCellWithReuseIdentifier: liveCollectionViewCellId)
        collectionView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        collectionView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *){
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        return collectionView
    }()
    
}

extension ZCLiveViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCollectionViewCellId, for: indexPath) as! ZCLiveCollectionViewCell
        cell.live = self.liveList[currentIndex]
        cell.parentVC = self
        return cell
    }
    
}
