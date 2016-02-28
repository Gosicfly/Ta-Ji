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
    
    /// 高亮时的背景色
    var highlightedBackgroundColor: UIColor?

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
    
    func setHighightedColor(backgruodColor: UIColor, textColor: UIColor) {
        self.highlightedBackgroundColor = backgruodColor
        self.highlightedTextColor = textColor
    }
}

/// 带选中效果的技能标签
class TASelectedLabel: TALabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.userInteractionEnabled = true
        self.highlightedTextColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        self.highlightedBackgroundColor = UIColor(red: 165/255, green: 104/255, blue: 175/255, alpha: 1)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("selectLabel")))
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor(red: 165/255, green: 104/255, blue: 175/255, alpha: 1).CGColor
    }
    
    func selectLabel() {
        self.highlighted = !self.highlighted
        if highlighted {
            self.backgroundColor = self.highlightedBackgroundColor
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
    }
}

