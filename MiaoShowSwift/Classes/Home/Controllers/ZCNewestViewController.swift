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
    
    var newestDataSource =  [ZCNewestLiveModel]()
    
    /// 分页
    var page : Int = 1
    
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
    
    private func requestData(pageIndex:Int){
        
        let apiServiceM = ZCApiServiceManager<ZCApiService>()
        let _ = apiServiceM.request(ZCApiService.newestLive(page: pageIndex), model: ZCNewestListModel.self) { (success, errorDesc, model)  in
            
            self.collectionView.endRefresh()
            if !success{
                self.view.showToast(text: errorDesc)
                return
            }
            self.page = pageIndex
            if self.page == 1{
               self.newestDataSource.removeAll()
            }
            if self.page >= model!.totalPage{
                self.collectionView.refreshNoMore()
            }
            self.newestDataSource += model!.list
            self.collectionView.reloadData()
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
        collectionView.contentInset = UIEdgeInsets.init(top: homeTitleViewHeight, left: 0, bottom: -kTabbarHeight-homeTitleViewHeight, right: 0)
        collectionView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZCNewestCollectionViewCell.self, forCellWithReuseIdentifier: newestCollectionViewCellId)
        collectionView.headerRefresh {
            self.requestData(pageIndex: 1)
        }
        
        collectionView.footerRefresh {
            self.requestData(pageIndex: self.page+1)
        }
        
        return collectionView
    }()

}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ZCNewestViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newestDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newestCollectionViewCellId, for: indexPath) as! ZCNewestCollectionViewCell
        cell.newestLive = self.newestDataSource[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let newestLive = self.newestDataSource[indexPath.row]
        if !newestLive.isAnimated {
            cell.layer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
            UIView.animate(withDuration: 0.5, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: { (result) in
                newestLive.isAnimated = true
            })
        }
    }
    
}
