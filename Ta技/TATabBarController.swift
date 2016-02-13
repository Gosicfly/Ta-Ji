//
//  TATabBarController.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TATabBarController: UITabBarController {
    
    lazy private var centerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: SCREEN_WIDTH / 5 * 2, y: 0, width: SCREEN_WIDTH / 5, height: self.tabBar.bounds.height))
        button.setImage(UIImage(named: "icon_tab_center"), forState: .Normal)
        button.backgroundColor = UIColor(red: 142/255, green: 92/255, blue: 152/255, alpha: 1)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRectInset(button.bounds, -5, 1), cornerRadius: 0).CGPath
        button.addTarget(self, action: Selector("presentPublishViewController"), forControlEvents: .TouchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBar.translucent = false
        self.tabBar.tintColor = selectedColor
        self.tabBar.barTintColor = tabBarColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChildViewControllers()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addCenterButton()
    }
    
    func setChildViewControllers() {
        self.addChildViewController(BaseHomeController(), title: "首页", image: "icon_tab_home")
        self.addChildViewController(CircleViewController(), title: "圈子", image: "icon_tab_circle")
        self.addChildViewController(UIViewController())
        self.addChildViewController(MessageViewController(), title: "消息", image: "icon_tab_message")
        self.addChildViewController(MeViewController(), title: "我的", image: "icon_tab_me")
    }
    
    func addCenterButton() {
        self.tabBar.addSubview(self.centerButton)
    }
    
    func presentPublishViewController() {
        let publishViewController = PublishViewController()
        self.presentViewController(UINavigationController(rootViewController: publishViewController), animated: true, completion: nil)
    }
}
