//
//  TeachersController.swift
//  Ta技
//
//  Created by Gosicfly on 16/3/3.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift

class TeachersController: UIViewController, TANavigationBarType {
    
    var teacherInfos: Results<TeacherInfo>

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(UINib(nibName: "SubscriberCell", bundle: nil), forCellReuseIdentifier: String(SubscriberCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .None
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
        self.teacherInfos = realm.objects(TeacherInfo)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.searchController.searchBar)
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.title = "我的师傅"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: #selector(TeachersController.back))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TeachersController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teacherInfos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension TeachersController: UISearchBarDelegate {
    
}
