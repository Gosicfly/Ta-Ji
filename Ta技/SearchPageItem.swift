//
//  SearchPageItem.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

enum SearchPageItemType {
    
    case People, Circle, Label
}

class SearchPageItem: UICollectionViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var type: SearchPageItemType = .People {
        didSet {
            switch(type) {
            case .People:
                self.searchBar.placeholder = "Ta技用户昵称/手机号码"
            case .Circle:
                self.searchBar.placeholder = "圈子名称/圈子号"
            case .Label:
                self.searchBar.placeholder = "标签名称"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
}

extension SearchController: UISearchBarDelegate {
    
}
