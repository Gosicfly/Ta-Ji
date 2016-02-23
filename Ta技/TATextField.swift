//
//  TATextField.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/29.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TATextField: UITextField {
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    init(frame: CGRect, edgeInsets: UIEdgeInsets = UIEdgeInsetsZero) {
        self.edgeInsets = edgeInsets
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var rect = self.editingRectForBounds(self.bounds)
        rect.size.height += 50
        return rect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return super.editingRectForBounds(UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets))
    }
}
