//
//  ZCNewestViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//  最新

import UIKit

class ZCNewestViewController: ZCAnimateNavAndTabViewController {

    let newestCollectionViewCellId = "newestCollectionViewCellId"
    
    var newestDataSource : ZCNewestListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        collectionView.beginHeaderRefreshing()
    }
    
    //MARK: Pravite
    
    private func createUI(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    private func requestData(){
        
        let apiServiceM = ZCApiServiceManager<ZCApiService>()
        let _ = apiServiceM.request(ZCApiService.newestLive(page: 1), model: ZCNewestListModel.self) { [weak self] (success, errorDesc, model)  in
            
            self?.collectionView.endRefresh()
            if !success{
                self?.view.showToast(text: errorDesc)
                return
            }
            
            self?.newestDataSource = model
            self?.collectionView.reloadData()
        }
        
    }

    //MARK: Lazy
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWH = ZCNewestCollectionViewCell.getItemWH()
        let space = ZCNewestCollectionViewCell.itemSpace()
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets.init(top: homeTitleViewHeight, left: 0, bottom: -kTabbarHeight, right: 0)
        collectionView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZCNewestCollectionViewCell.self, forCellWithReuseIdentifier: newestCollectionViewCellId)
        collectionView.headerRefresh { [weak self] in
            self?.requestData()
        }
        return collectionView
    }()
}


// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ZCNewestViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newestDataSource?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newestCollectionViewCellId, for: indexPath) as! ZCNewestCollectionViewCell
        cell.newestLive = self.newestDataSource?.list?[indexPath.row]
        
        return cell
    }
    
}
