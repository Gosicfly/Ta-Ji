//
//  CircleCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class CircleCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var numberOfOnline: UILabel!
    
    @IBOutlet weak var totalNumber: UILabel!
    
    @IBOutlet weak var chattingButton: UIButton!
    
    // cell宽度的内嵌值
    private let inset = 6
    
    // 重载frame属性，改变cell的宽度
    override var frame: CGRect {
        set {
            var rect = newValue
            rect.origin.x += CGFloat(inset)
            rect.size.width -= CGFloat(2*inset)
            super.frame = rect
        }
        get {
            return super.frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.height / 12
        self.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        layoutIfNeeded()
        self.chattingButton.layer.cornerRadius = self.chattingButton.frame.height / 2
        self.chattingButton.layer.masksToBounds = true
    }
}
