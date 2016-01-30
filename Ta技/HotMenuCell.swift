//
//  HotMenuCell.swift
//  TA技
//
//  Created by Gosicfly on 16/1/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class HotMenuCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    
    var name: String {
        set {
            self.titleLabel.text = newValue
        }
        get {
            guard titleLabel != nil else {
                fatalError("_titleLabel found nil")
            }
            return titleLabel.text!
        }
    }
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.highlightedTextColor = selectedColor
        self.titleLabel.textAlignment = .Center
        self.titleLabel.font = UIFont.systemFontOfSize(14)
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.titleLabel.center = self.contentView.center
        self.titleLabel.bounds = self.contentView.bounds
    }
    
}
