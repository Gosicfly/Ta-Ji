//
//  MeViewController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/13.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit

class MeViewController: UIViewController, TANavigationBarType {

    @IBOutlet weak var blurBackgroundImageView: UIImageView! {
        didSet {
            print("imageview")
        }
    }
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var avatar: UIImageView! 
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var school: UILabel!
    
    @IBOutlet weak var signature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("search"))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.masksToBounds = true
    }
}
