//
//  SkillCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/4/2.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit

class SkillCell: UICollectionViewCell {
    
    var skillName: String {
        set {
            self.skillLabel.text = newValue
        }
        get {
            return self.skillLabel.text!
        }
    }
    
    var skillLabel: TALabel! {
        didSet {
            self.contentView.addSubview(skillLabel)
            skillLabel.snp_makeConstraints { (make) in
                make.left.equalTo(self.contentView)
                make.right.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        self.skillLabel = {
            let label = TALabel()
            label.layer.masksToBounds = true
            label.text = "暂无"
            label.backgroundColor = UIColor.yellowColor()
            return label
        }()
    }
}
