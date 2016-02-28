//
//  AddLabelController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/28.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddLabelController: UIViewController, TANavigationBarType {

    @IBOutlet weak var submittingButton: UIButton! {
        didSet {
            submittingButton.layer.cornerRadius = 8
            submittingButton.layer.masksToBounds = true
            submittingButton.layer.borderWidth = 1
            submittingButton.layer.borderColor = UIColor(red: 66/255, green: 255/255, blue: 209/255, alpha: 1).CGColor
        }
    }
    
    @IBAction func submit(sender: UIButton) {
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        self.title = "添加标签"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+自定义", style: .Plain, target: self, action: Selector("addCustomLabel"))
    }

    // MARK: - Selector
    @objc private func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func addCustomLabel() {
        SVProgressHUD.showInfoWithStatus("目前暂不支持自定义标签")
    }
}
