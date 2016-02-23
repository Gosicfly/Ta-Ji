//
//  SubscribeViewController.swift
//  TA技
//
//  Created by Gosicfly on 16/1/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        label.center = SCREEN_CENTER
        label.text = "关注"
        self.view.addSubview(label)
    }
    
}
