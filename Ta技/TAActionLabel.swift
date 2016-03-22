//
//  TAActionLabel.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TAActionLabel: UILabel {
    
    var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor(red: 124/255, green: 82/255, blue: 138/255, alpha: 1)
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(TAActionLabel.performAction))
        self.addGestureRecognizer(gesture)
    }
    
    override func layoutSubviews() {
        self.sizeToFit()
    }
    
    // MARK : - Selector
    func performAction() {
        self.action!()
    }
}
