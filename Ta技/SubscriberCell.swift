//
//  SubscribeCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SubscriberCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var signature: UILabel!
    
    let separatorLine = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        layoutIfNeeded()
        self.avatar.layer.cornerRadius = self.avatar.bounds.width / 2
        self.avatar.layer.masksToBounds = true
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 10, y: self.contentView.bounds.height))
        path.addLineToPoint(CGPoint(x: self.contentView.frame.width - 20, y: self.contentView.bounds.height))
        separatorLine.path = path.CGPath
        separatorLine.strokeColor = UIColor(red: 54/255, green: 69/255, blue: 89/255, alpha: 1).CGColor
        separatorLine.lineWidth = 0.1
        self.contentView.layer.addSublayer(separatorLine)
    }
}
