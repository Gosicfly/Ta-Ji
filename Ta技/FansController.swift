//
//  FansController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class FansController: UIViewController, TANavigationBarType {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(UINib(nibName: "SubscribeCell", bundle: nil), forCellReuseIdentifier: String(SubscribeCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 50
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func setNavigationBar() {
        self.title = "被订阅"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension FansController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SubscribeCell)) as! SubscribeCell
        return cell
    }
}
