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
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
}
