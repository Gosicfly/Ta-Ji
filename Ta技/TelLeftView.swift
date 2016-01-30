//
//  TelHelperView.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/29.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TelLeftView: UIView {

    let label = UILabel()
    
    init(frame: CGRect, areaCode: String) {
        super.init(frame: frame)
        self.label.text = areaCode
        self.addSubview(self.label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.label.center = self.center
        self.label.frame = CGRectInset(self.bounds, 10, 0)
    }
}
