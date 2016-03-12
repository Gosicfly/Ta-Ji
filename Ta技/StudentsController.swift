//
//  StudentsController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift

class StudentsController: UIViewController, TANavigationBarType {
    
    var studentInfos: Results<(StudentInfo)>
    
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
        self.studentInfos = realm.objects(StudentInfo)
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
        self.title = "徒弟"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension StudentsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentInfos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscriberCell)) as! SubscriberCell
        if self.studentInfos[indexPath.row].avatarURL == defaultAvatarURL {
            cell.avatar.image = UIImage(contentsOfFile: defaultAvatarURL)
        } else {
            cell.avatar.kf_setImageWithURL(self.studentInfos[indexPath.row].avatarURL.convertToURL()!)
        }
        cell.name.text = self.studentInfos[indexPath.row].userName
        cell.signature.text = self.studentInfos[indexPath.row].signature
        return cell
    }
}

extension StudentsController: UISearchBarDelegate {
    
}