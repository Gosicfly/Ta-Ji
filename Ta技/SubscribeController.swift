//
//  SubscribeController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SubscribeController: UIViewController, TANavigationBarType {

    @IBOutlet weak var seachBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(UINib(nibName: "SubscribeCell", bundle: nil), forCellReuseIdentifier: String(SubscribeCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.title = "订阅"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension SubscribeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscribeCell)) as! SubscribeCell
        return cell
    }
}