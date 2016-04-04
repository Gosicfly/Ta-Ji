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
            imageView.contentMode = .ScaleToFill
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = defaultBackgroundColor
        self.setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.contentView.bounds
        self.imageView.frame.size.height -= 12
        self.imageView.frame.origin.y += 6
        self.imageView.frame.size.width -= 14
        self.imageView.frame.origin.x -= 7
        self.imageView.center = self.contentView.center     //这个地方必须用contentView，直接用self.center会出现错误
    }
    
    func setSubviews() {
        self.imageView = UIImageView()
    }
}
