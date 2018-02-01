//
//  ZCHomeViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

let homeTitleViewHeight : CGFloat = 50

class ZCHomeViewController: ZCBaseViewController {
    
    private let homeCollectionCellId = "homeCollectionCellId"
    
    private var childVCs : [UIViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        automaticallyAdjustsScrollViewInsets = false
        
        childVCs = [ZCHotViewController(),ZCNewestViewController(),ZCAttentionViewController()]
        for childViewController in childVCs {
            addChildViewController(childViewController)
        }
        
        createUI()
        
    }

    private func createUI(){
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(kNavigationBarHeight)
            $0.left.right.equalTo(self.view)
            $0.height.equalTo(homeTitleViewHeight)
        }
    }
    
    //MARK: Lazy
    
    lazy var titleView : ZCHomeCategoryTitleView = {
        let titleView = ZCHomeCategoryTitleView.init(titles: ["热门","最新","关注"])
        titleView.titleViewClickClosure = { [unowned self]
            (selecetedIndex) in
            self.collectionView.setContentOffset(CGPoint(x:kScreenWidth*CGFloat(selecetedIndex),y:0), animated: true)
            
        }
        return titleView
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: kScreenWidth, height: kScreenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: homeCollectionCellId)
        return collectionView
    }()
}


// MARK: -UICollectionViewDelegate,UICollectionViewDataSource

extension ZCHomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCollectionCellId, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}


// MARK: - UIScrollViewDelegate

extension ZCHomeViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        titleView.sliderMoveWithOffset(offset: scrollView.contentOffset.x/kScreenWidth)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/kScreenWidth)
        titleView.selectedIndex = index
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = Int(scrollView.contentOffset.x/kScreenWidth)
        titleView.selectedIndex = index
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/kScreenWidth)
        titleView.selectedIndex = index
    }
}

