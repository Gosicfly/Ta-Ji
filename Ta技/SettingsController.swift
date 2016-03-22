//
//  SettingsController.swift
//  Ta技
//
//  Created by Gosicfly on 16/3/16.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingsController: UIViewController, TANavigationBarType {
    
    var tableView: UITableView! {
        didSet {
            self.view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setSubviews()
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func setNavigationBar() {
        self.title = "设置"
    }
    
    func setSubviews() {
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
    }

    func logout() {
        SVProgressHUD.show()
        TAUtilsManager.userInfoManager.writeloginState(false)
        TAVCManager.resetAllControllers()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            SVProgressHUD.dismiss()
            UIApplication.sharedApplication().windows[0].rootViewController = TAVCManager.loginController
        }
    }
    
}

extension SettingsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "登出"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0:
            self.logout()
        default:
            break
        }
    }
}
