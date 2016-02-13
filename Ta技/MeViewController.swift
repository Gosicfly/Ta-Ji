//
//  MeViewController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/13.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class MeViewController: UIViewController, TANavigationBarType {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("search"))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
    }

}
