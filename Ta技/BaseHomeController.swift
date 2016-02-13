//
//  HomeViewController.swift
//  TA技
//
//  Created by Gosicfly on 16/1/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class BaseHomeController: UIViewController, TANavigationBarType {
    
    let hotViewController = HotViewController()
    
    let concernViewController = ConcernViewController()
    
    let activityViewController = ActivityViewController()
    
    var currentChildViewController: UIViewController!
    
    var nextChildViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setChildViewControllers()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("search"))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
        let titleView = HomeTitleView()
        titleView.delegate = self
        self.navigationItem.titleView = titleView
    }
    
    func setChildViewControllers() {
        self.addChildViewController(hotViewController)
        self.addChildViewController(concernViewController)
        self.addChildViewController(activityViewController)
        self.view.addSubview(hotViewController.view)
        self.currentChildViewController = self.hotViewController
    }
    
    func search() {
        //TODO
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

extension BaseHomeController: HomeTitleViewDelegate {
    
    func transition(fromeViewController  fromeViewController: UIViewController, toViewController: UIViewController, completion: ((Bool) -> Void)?) {
        self.transitionFromViewController(fromeViewController, toViewController: toViewController, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: nil, completion: completion)
    }
}
