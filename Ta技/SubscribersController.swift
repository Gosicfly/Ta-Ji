//
//  SubscribeController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift

class SubscribersController: UIViewController, TANavigationBarType {
    
    var subscriberInfos: Results<(SubscriberInfo)>

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(UINib(nibName: "SubscriberCell", bundle: nil), forCellReuseIdentifier: String(SubscriberCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
            tableView.tableFooterView = UIView()
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
        self.subscriberInfos = realm.objects(SubscriberInfo)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.view.addSubview(self.searchController.searchBar)
    }
    
    func setNavigationBar() {
        self.title = "订阅"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SubscribersController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subscriberInfos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        cell.avatar.kf_setImageWithURL(self.subscriberInfos[indexPath.row].avatarURL.convertToURL()!)
        cell.name.text = self.subscriberInfos[indexPath.row].userName
        cell.signature.text = self.subscriberInfos[indexPath.row].signature
        return cell
    }
}

extension SubscribersController: UISearchBarDelegate {
    
}