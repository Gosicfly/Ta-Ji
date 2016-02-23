//
//  TALabel.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/16.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

/// 技能标签
class TALabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFontOfSize(12)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.systemFontOfSize(12)
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.text = "  " + self.text! + "  "
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
}
