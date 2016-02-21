//
//  TARefreshControl.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TARefreshControl: UIRefreshControl {
    
    
    override init() {
        super.init()
        self.tintColor = UIColor.whiteColor()
        self.attributedTitle = NSAttributedString(string: "加载完毕", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
