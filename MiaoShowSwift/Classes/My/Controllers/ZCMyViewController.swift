//
//  ZCMyViewController.swift
//  MiaoShowSwift
//
//  Created by 赵琛 on 2018/1/25.
//  Copyright © 2018年 赵琛. All rights reserved.
//

import UIKit

class ZCMyViewController: ZCBaseViewController {
    
    private let ZCMyInfoCellId = "ZCMyInfoCellId"
    
    //MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Pravite
    
    private func createUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view)
            $0.bottom.equalTo(self.view).offset(-kTabbarHeight)
        }
    }

    //MARK: Lazy
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.colorFormHex(hexValue: 0xf0f0f0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ZCMyInfoCell.self, forCellReuseIdentifier: ZCMyInfoCellId)
        tableView.tableHeaderView = headerView
        if #available(iOS 11.0, *){
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()
    
    private lazy var headerView : ZCMyInformationHeaderView = {
        let headerView = ZCMyInformationHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 300))
        headerView.accountInfo = ZCAccountManager.sharedInstance().getAccount()
        return headerView
    }()

}

extension ZCMyViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ZCMyInfoCellDataSourceManager.shareInstanced().dataSource().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = ZCMyInfoCellDataSourceManager.shareInstanced().dataSource()[section]
        return group.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZCMyInfoCellId, for: indexPath) as! ZCMyInfoCell
        let group = ZCMyInfoCellDataSourceManager.shareInstanced().dataSource()[indexPath.section]
        cell.cellModel = group[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension ZCMyViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scaleBackgroundImageView(contentOffset: scrollView.contentOffset)
    }
    
}
