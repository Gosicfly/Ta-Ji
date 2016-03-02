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

extension UIImageView {
    /**
     / !!!只有当 imageView 不为nil 时，调用此方法才有效果
     
     :param: radius 圆角半径
     */
    func gf_addCorner(radius radius: CGFloat) {
        self.image = self.image?.gf_drawRectWithRoundedCorner(radius: radius, self.bounds.size)
    }
}

extension UIImage {
    func gf_drawRectWithRoundedCorner(radius radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: radius, height: radius)).CGPath)
        CGContextClip(context)
        self.drawInRect(rect)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output
    }
}
