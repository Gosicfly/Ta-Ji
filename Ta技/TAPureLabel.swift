//
//  TAPureLabel.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TAPureLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 0
        self.textColor = UIColor(red: 178/255, green: 183/255, blue: 184/255, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
