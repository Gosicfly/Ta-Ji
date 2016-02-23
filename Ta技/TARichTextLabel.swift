//
//  TARichTextLabel.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TARichTextLabel: UILabel {
    
    init(text:String, frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
    }
    
    override func layoutSubviews() {
    }
}
