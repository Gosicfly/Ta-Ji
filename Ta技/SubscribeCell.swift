//
//  SubscribeCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SubscribeCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var signature: UILabel!
    
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
    }
}
