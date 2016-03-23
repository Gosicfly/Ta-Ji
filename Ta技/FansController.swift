//
//  FansController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift

class FansController: UIViewController, TANavigationBarType {
    
    var fansInfos: Results<FansInfo>

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(UINib(nibName: "SubscriberCell", bundle: nil), forCellReuseIdentifier: String(SubscriberCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .Minimal
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    init() {
        self.fansInfos = realm.objects(FansInfo)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.title = "被订阅"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: #selector(FansController.back))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FansController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fansInfos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        if self.fansInfos[indexPath.row].avatarURL.hasPrefix("/var/mobile/") || self.fansInfos[indexPath.row].avatarURL.hasPrefix("/Users/") {
            cell.avatar.image = UIImage(contentsOfFile: defaultAvatarURL)
        } else {
            cell.avatar.kf_setImageWithURL(self.fansInfos[indexPath.row].avatarURL.convertToURL()!)
        }
        cell.name.text = self.fansInfos[indexPath.row].userName
        cell.signature.text = self.fansInfos[indexPath.row].signature
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension FansController: UISearchBarDelegate {
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.view.hitTest(CGPoint(x:0, y:tableView.bounds.size.height-2), withEvent: nil) == self.tableView {
            if scrollView.contentOffset.y > 0 {
                scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
            }
        }
    }
}