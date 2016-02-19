//
//  RecommendPageItem.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/19.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class RecommendPageItem: UICollectionViewCell {
    
    var tableView: UITableView! {
        didSet {
            self.addSubview(tableView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -private method
    private func setSubviews() {
        self.tableView = UITableView(frame: SCREEN_BOUNDS, style: .Plain)
    }
}
