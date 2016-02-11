//
//  GFCycleScrollViewCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/6.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class GFCycleScrollViewCell: UICollectionViewCell {
    
    var imageView: UIImageView! {
        didSet {
            self.addSubview(self.imageView)
        }
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.contentView.bounds
        self.imageView.center = self.contentView.center     //这个地方必须用contentView，直接用self.center会出现错误
    }
}
