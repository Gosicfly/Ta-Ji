//
//  MeMenuCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/17.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class MeMenuCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var optionalHint: UILabel!
    
    let separatorLine = CAShapeLayer()
    
    var section: Int!
    
    var row: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        layoutIfNeeded()
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 10, y: self.contentView.bounds.height))
        path.addLineToPoint(CGPoint(x: self.contentView.frame.width - 20, y: self.contentView.bounds.height))
        separatorLine.path = path.CGPath
        separatorLine.strokeColor = UIColor(red: 54/255, green: 69/255, blue: 89/255, alpha: 1).CGColor
        separatorLine.lineWidth = 0.4
        self.contentView.layer.addSublayer(separatorLine)
        switch (section, row) {
        case (0, 1):
            separatorLine.removeFromSuperlayer()
        case (1, 1):
            separatorLine.removeFromSuperlayer()
        default:
            break
        }
    }
}
