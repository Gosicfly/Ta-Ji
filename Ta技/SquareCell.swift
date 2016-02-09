//
//  SquareCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/7.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SquareCell: UICollectionViewCell {
    
    var showImageView: UIImageView! {
        didSet {
            self.addSubview(self.showImageView)
            self.showImageView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.top.equalTo(self)
                make.bottom.equalTo(self).offset(-22)
            }
        }
    }
    
    var avatarImageView: UIImageView! {
        didSet {
            self.addSubview(self.avatarImageView)
            self.avatarImageView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self).offset(10)
                make.centerY.equalTo(self.showImageView.snp_bottom)
                make.bottom.equalTo(self).offset(-5)
                make.width.equalTo(self.avatarImageView.snp_height)
            }
        }
    }
    
    var squareMaskView: UIView! {
        didSet {
            self.addSubview(self.squareMaskView)
            self.squareMaskView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.bottom.equalTo(self.showImageView.snp_bottom)
                make.top.equalTo(self.avatarImageView.snp_top).offset(-5)
            }
            self.squareMaskView.backgroundColor = UIColor.blackColor()
            self.squareMaskView.alpha = 0.5
        }
    }
    
    var titleLabel: UILabel! {
        didSet {
            self.addSubview(self.titleLabel)
            self.titleLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.avatarImageView.snp_right).offset(7)
                make.right.equalTo(self)
                make.top.equalTo(self.squareMaskView.snp_top).offset(5)
                make.bottom.equalTo(self.squareMaskView.snp_bottom).offset(-5)
            }
            self.titleLabel.text = "加载中..."
            self.titleLabel.textColor = defaultTintColot
            self.titleLabel.font = UIFont.systemFontOfSize(12)
        }
    }
    
    var supportImageView: UIImageView! {
        didSet {
            self.addSubview(self.supportImageView)
            self.supportImageView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.avatarImageView.snp_right).offset(7)
                make.width.equalTo(self.supportImageView.snp_height)
                make.top.equalTo(self.showImageView.snp_bottom).offset(5)
                make.bottom.equalTo(self).offset(-5)
            }
        }
    }
    
    var numberOfSupporters: UILabel! {
        didSet {
            self.addSubview(self.numberOfSupporters)
            self.numberOfSupporters.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.supportImageView.snp_right).offset(4)
                make.right.equalTo(self)
                make.top.equalTo(self.supportImageView)
                make.bottom.equalTo(self.supportImageView)
            }
            self.numberOfSupporters.text = "1024"
            self.numberOfSupporters.textColor = defaultTintColot
            self.numberOfSupporters.font = UIFont.systemFontOfSize(12)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        self.showImageView = UIImageView(image: UIImage(named: "loading"))
        self.avatarImageView = UIImageView(image: UIImage(named: "loading"))
        self.squareMaskView = UIView()
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.width / 2
        self.avatarImageView.layer.masksToBounds = true
        self.titleLabel = UILabel()
        self.supportImageView = UIImageView(image: UIImage(named: "support"))
        self.numberOfSupporters = UILabel()
        
        self.bringSubviewToFront(self.avatarImageView)
        self.bringSubviewToFront(self.titleLabel)
    }
    
}
