//
//  SquareCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/7.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SquareCell: UICollectionViewCell, HotCellItem {
    
    var name: UILabel! = UILabel()
    
    var favorNumber = "0"
    
    var picture: UIImageView! {
        didSet {
            self.addSubview(self.picture)
            self.picture.contentMode = .ScaleToFill
            self.picture.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.top.equalTo(self)
                make.bottom.equalTo(self).offset(-22)
            }
        }
    }
    
    var avatar: UIImageView! {
        didSet {
            self.addSubview(self.avatar)
            self.avatar.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self).offset(10)
                make.centerY.equalTo(self.picture.snp_bottom)
                make.bottom.equalTo(self).offset(-5)
                make.width.equalTo(self.avatar.snp_height)
            }
        }
    }
    
    var squareMaskView: UIView! {
        didSet {
            self.addSubview(self.squareMaskView)
            self.squareMaskView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.bottom.equalTo(self.picture.snp_bottom)
                make.top.equalTo(self.avatar.snp_top).offset(-5)
            }
            self.squareMaskView.backgroundColor = UIColor.blackColor()
            self.squareMaskView.alpha = 0.5
        }
    }
    
    var text: UILabel! {
        didSet {
            self.addSubview(self.text)
            self.text.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.avatar.snp_right).offset(7)
                make.right.equalTo(self)
                make.top.equalTo(self.squareMaskView.snp_top).offset(5)
                make.bottom.equalTo(self.squareMaskView.snp_bottom).offset(-5)
            }
            self.text.text = "加载中..."
            self.text.textColor = defaultTintColot
            self.text.font = UIFont.systemFontOfSize(12)
        }
    }
    
    var likeImageView: UIImageView! {
        didSet {
            self.addSubview(self.likeImageView)
            self.likeImageView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.avatar.snp_right).offset(7)
                make.width.equalTo(self.likeImageView.snp_height)
                make.top.equalTo(self.picture.snp_bottom).offset(2)
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
            self.numberOfLikers.text = "0"
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
        self.picture = UIImageView(image: UIImage(named: "loading"))
        self.avatar = UIImageView(image: UIImage(named: "loading"))
        self.squareMaskView = UIView()
        self.text = UILabel()
        self.likeImageView = UIImageView(image: UIImage(named: "icon_tab_home_hot_favor"))
        self.numberOfLikers = UILabel()
        
        self.bringSubviewToFront(self.avatar)
        self.bringSubviewToFront(self.text)
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        self.avatar.gf_addCorner(radius: self.avatar.bounds.width / 2)
    }
    
}
