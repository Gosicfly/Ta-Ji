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
    
    let concernViewController = SubscribeViewController()
    
    let activityViewController = ActivityViewController()
    
    var currentChildViewController: UIViewController!
    
    var nextChildViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setChildViewControllers()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(BaseHomeController.search))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
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
        let searchController = SearchController()
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

// MARK: - HomeTitleViewDelegate
extension BaseHomeController: HomeTitleViewDelegate {
    
    func transition(fromeViewController  fromeViewController: UIViewController, toViewController: UIViewController) {
        self.nextChildViewController.view.alpha = 0
        self.transitionFromViewController(fromeViewController,
                                          toViewController: toViewController,
                                          duration: 0.22,
                                          options: .CurveEaseIn,
                                          animations: {
            self.currentChildViewController.view.alpha = 0
            self.nextChildViewController.view.alpha = 1
            },
                                          completion: nil)
    }
}
