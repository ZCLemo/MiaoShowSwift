//
//  ZCHotViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//  最热

import UIKit

class ZCHotViewController: ZCBaseViewController {

    let hotBannerCollectionViewCellId = "hotBannerCollectionViewCellId"
    
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
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZCHotBannerCollectionViewCell.self, forCellWithReuseIdentifier: hotBannerCollectionViewCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
}


// MARK: -UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension ZCHotViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotBannerCollectionViewCellId, for: indexPath) as! ZCHotBannerCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width:kScreenWidth,height:ZCHotBannerCollectionViewCell.cellHeight())
        }
        return CGSize(width:kScreenWidth,height:400)
    }
    
}
