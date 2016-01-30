//
//  TATextField.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/29.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TATextField: UITextField {
    
    var edgeInsets: UIEdgeInsets
    
    init(frame: CGRect, edgeInsets: UIEdgeInsets = UIEdgeInsetsZero) {
        self.edgeInsets = edgeInsets
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var rect = self.editingRectForBounds(self.bounds)
        rect.size.height += 60
        return rect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return super.editingRectForBounds(UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets))
    }
}
