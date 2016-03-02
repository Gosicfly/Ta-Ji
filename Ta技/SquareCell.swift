//
//  SquareCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/7.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
var a = 1
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
    
    var likeImageView: UIImageView! {
        didSet {
            self.addSubview(self.likeImageView)
            self.likeImageView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.avatarImageView.snp_right).offset(7)
                make.width.equalTo(self.likeImageView.snp_height)
                make.top.equalTo(self.showImageView.snp_bottom).offset(2)
                make.bottom.equalTo(self).offset(-2)
            }
        }
    }
    
    var numberOfLikers: UILabel! {
        didSet {
            self.addSubview(self.numberOfLikers)
            self.numberOfLikers.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.likeImageView.snp_right).offset(4)
                make.right.equalTo(self)
                make.top.equalTo(self.likeImageView)
                make.bottom.equalTo(self.likeImageView)
            }
            self.numberOfLikers.text = "1024"
            self.numberOfLikers.textColor = defaultTintColot
            self.numberOfLikers.font = UIFont.systemFontOfSize(12)
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
        self.titleLabel = UILabel()
        self.likeImageView = UIImageView(image: UIImage(named: "icon_tab_home_hot_favor"))
        self.numberOfLikers = UILabel()
        
        self.bringSubviewToFront(self.avatarImageView)
        self.bringSubviewToFront(self.titleLabel)
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        self.avatarImageView.gf_addCorner(radius: self.avatarImageView.bounds.width / 2)
    }
    
}
