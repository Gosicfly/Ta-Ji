//
//  LabelPage.swift
//  Ta技
//
//  Created by Gosicfly on 16/4/3.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import SVProgressHUD

class LabelPage: UICollectionViewCell {
    
    var results: [UserInfo] = []
    
    var tableView: UITableView! {
        didSet {
            self.contentView.addSubview(tableView)
            tableView.snp_makeConstraints { (make) in
                make.left.equalTo(self.contentView)
                make.right.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = self.searchBar
            tableView.tableFooterView = UIView()
            tableView.estimatedRowHeight = 10
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .None
            tableView.registerNib(UINib(nibName: String(SubscriberCell), bundle: nil), forCellReuseIdentifier: String(SubscriberCell))
        }
    }
    
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "标签名称"
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = navigationBarColor
        searchController.searchBar.searchBarStyle = .Minimal
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    lazy var searchBar: UISearchBar = {
        return self.searchController.searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        self.tableView = UITableView()
    }
}

extension LabelPage: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        cell.name.text = self.results[indexPath.row].username
        cell.avatar.kf_setImageWithURL(self.results[indexPath.row].avatar.convertToURL()!)
        cell.signature.text = self.results[indexPath.row].signature
        return cell
    }
}

extension LabelPage: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        SVProgressHUD.show()
        Alamofire.request(.GET, "http://taji.whutech.com/User/search?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&wd=\(self.searchBar.text!.convertToUTF8()!)").responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            let json = JSON(response.result.value!)
            if json["status"].string! == "200" {
                SVProgressHUD.showSuccessWithStatus("成功")
                self.results.removeAll()
                for (_, subJson) in json["data"] {
                    var info = UserInfo()
                    info.avatar = subJson["avatar"].string!
                    info.signature = subJson["signature"].string!
                    info.username = subJson["username"].string!
                    info.userid = subJson["userid"].string!
                    self.results.append(info)
                }
                self.tableView.reloadData()
            } else {
                SVProgressHUD.showErrorWithStatus("网络出错")
            }
        }
    }
}

extension LabelPage: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
}