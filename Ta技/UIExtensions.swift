//
//  TabBarController+extension.swift
//  TA技
//
//  Created by Gosicfly on 16/1/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func addChildViewController(childController: UIViewController, title: String?, image: String?) {
        childController.tabBarItem.title = title
        childController.title = title
        if let image = image {
            childController.tabBarItem.image = UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal)
            childController.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        self.addChildViewController(UINavigationController(rootViewController: childController))
    }
}

extension UINavigationController {
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
}