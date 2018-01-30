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
    let hotLiveCollectionViewCellId = "hotLiveCollectionViewCellId"
    
    let dGroup = DispatchGroup()
    
    var hotDatasource : ZCLiveListModel?
    
    var bannerDatasource : ZCBannerListModel?
    
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
    
    
    /// 查询数据
    private func requestData(){
        requestBanner()
        requestHotList()
        notifyRequsetEnd()
    }
    
    /// 查询广告
    private func requestBanner(){
        dGroup.enter()
        let serviceM = ZCApiServiceManager<ZCApiService>()
        let _ = serviceM.request(ZCApiService.getAD, model: ZCBannerListModel.self) { [weak self] (success, errorDesc, model) in
            
            self?.dGroup.leave()
            if !success {
                self?.view.showToast(text: errorDesc)
                return
            }
            self?.bannerDatasource = model
        }
        
    }
    
    /// 直播列表
    private func requestHotList(){
        let serviceM = ZCApiServiceManager<ZCApiService>()
        dGroup.enter()
        let _ = serviceM.request(ZCApiService.hotLive(page: 1), model: ZCLiveListModel.self) { [weak self] (success, errorDesc, model) in
            
            self?.dGroup.leave()
            if !success {
                self?.view.showToast(text: errorDesc)
                return
            }
            self?.hotDatasource = model
        }
        
    }
    
    private func notifyRequsetEnd(){
        dGroup.notify(queue: DispatchQueue.main) {
            self.collectionView.endRefresh()
            self.collectionView.reloadData()
        }
    }

    //MARK: Lazy
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZCHotBannerCollectionViewCell.self, forCellWithReuseIdentifier: hotBannerCollectionViewCellId)
        collectionView.register(ZCHotLiveCollectionViewCell.self, forCellWithReuseIdentifier: hotLiveCollectionViewCellId)
        
        collectionView.headerRefresh { [weak self] in
            self?.requestData()
        }
        
//        collectionView.footerRefresh {
//            [weak self] in
//
//        }
        
        return collectionView
    }()
}

// MARK: -UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension ZCHotViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.hotDatasource?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotBannerCollectionViewCellId, for: indexPath) as! ZCHotBannerCollectionViewCell
            cell.bannerList = self.bannerDatasource?.customData
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotLiveCollectionViewCellId, for: indexPath) as! ZCHotLiveCollectionViewCell
        cell.hotLive = self.hotDatasource?.list?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width:kScreenWidth,height:ZCHotBannerCollectionViewCell.cellHeight())
        }
        return CGSize(width:kScreenWidth,height:ZCHotLiveCollectionViewCell.cellHeight())
    }
    
}
