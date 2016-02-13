//
//  HotMenuCell.swift
//  TA技
//
//  Created by Gosicfly on 16/1/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class HotMenu: UICollectionViewCell {
    
    var titleLabel: UILabel! {
        didSet {
            self.titleLabel.textColor = defaultTintColot
            self.titleLabel.highlightedTextColor = selectedColor
            self.titleLabel.textAlignment = .Center
            self.titleLabel.font = UIFont.systemFontOfSize(14)
            self.addSubview(self.titleLabel)
        }
    }
    
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
        super.init(frame: frame)
        self.setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.titleLabel.center = self.contentView.center
        self.titleLabel.bounds = self.contentView.bounds
    }
    
    func setSubViews() {
        self.titleLabel = UILabel()
    }
}
