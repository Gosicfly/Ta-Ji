//
//  SubscribeController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SubscriberController: UIViewController, TANavigationBarType {

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
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.definesPresentationContext = true
        self.hidesBottomBarWhenPushed = true
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
extension SubscriberController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        return cell
    }
}

extension SubscriberController: UISearchBarDelegate {
    
}