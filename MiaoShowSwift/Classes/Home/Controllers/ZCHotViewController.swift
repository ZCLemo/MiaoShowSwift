//
//  ZCHotViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/26.
//  Copyright © 2018年 赵琛. All rights reserved.
//  最热

import UIKit

class ZCHotViewController: ZCAnimateNavAndTabViewController {

    let hotBannerCollectionViewCellId = "hotBannerCollectionViewCellId"
    let hotLiveCollectionViewCellId = "hotLiveCollectionViewCellId"
    
    let dGroup = DispatchGroup()
    
    var hotDatasource = [ZCLiveModel]()
    
    var bannerDatasource =  [ZCBannerModel]()
    
    var page = 1
    
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
        requestHotList(pageIndex: 1)
        notifyRequsetEnd()
    }
    
    /// 查询广告
    private func requestBanner(){
        dGroup.enter()
        let serviceM = ZCApiServiceManager<ZCApiService>()
        let _ = serviceM.request(ZCApiService.getAD, model: ZCBannerListModel.self) { (success, errorDesc, model) in
            
            self.dGroup.leave()
            if !success {
                self.view.showToast(text: errorDesc)
                return
            }
            self.bannerDatasource.removeAll()
            self.bannerDatasource += model!.customData
        }
        
    }
    
    /// 直播列表
    private func requestHotList(pageIndex:Int){
        let serviceM = ZCApiServiceManager<ZCApiService>()
        dGroup.enter()
        let _ = serviceM.request(ZCApiService.hotLive(page: pageIndex), model: ZCLiveListModel.self) { (success, errorDesc, model) in
            
            self.dGroup.leave()
            if !success {
                self.view.showToast(text: errorDesc)
                return
            }
            self.page = pageIndex
            if self.page == 1{
                self.hotDatasource.removeAll()
            }
            if self.page >= model!.counts{
                self.collectionView.refreshNoMore()
            }
            self.hotDatasource += model!.list
        }
        
    }
    
    /// 请求结束
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
        collectionView.contentInset = UIEdgeInsets.init(top: homeTitleViewHeight, left: 0, bottom: -kTabbarHeight-homeTitleViewHeight, right: 0)
        collectionView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZCHotBannerCollectionViewCell.self, forCellWithReuseIdentifier: hotBannerCollectionViewCellId)
        collectionView.register(ZCHotLiveCollectionViewCell.self, forCellWithReuseIdentifier: hotLiveCollectionViewCellId)
        
        collectionView.headerRefresh {
            self.requestData()
        }
        
        collectionView.footerRefresh {
            self.requestHotList(pageIndex: self.page+1)
            self.notifyRequsetEnd()
        }
        
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
        return self.hotDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotBannerCollectionViewCellId, for: indexPath) as! ZCHotBannerCollectionViewCell
            cell.bannerList = self.bannerDatasource
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotLiveCollectionViewCellId, for: indexPath) as! ZCHotLiveCollectionViewCell
        cell.hotLive = self.hotDatasource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width:kScreenWidth,height:ZCHotBannerCollectionViewCell.cellHeight())
        }
        return CGSize(width:kScreenWidth,height:ZCHotLiveCollectionViewCell.cellHeight())
    }
    
}


