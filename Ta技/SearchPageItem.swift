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

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.bounces = false
            tableView.tableHeaderView = self.searchController.searchBar
            tableView.tableFooterView = UIView()
        }
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    weak var menuView: UICollectionView?
    
    var type: SearchPageItemType = .People {
        didSet {
            switch(type) {
            case .People:
                self.searchController.searchBar.placeholder = "Ta技用户昵称/手机号码"
            case .Circle:
                self.searchController.searchBar.placeholder = "圈子名称/圈子号"
            case .Label:
                self.searchController.searchBar.placeholder = "标签名称"
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

extension SearchPageItem: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        UIView.animateWithDuration(0.8) { () -> Void in
            self.menuView?.alpha = 0
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        UIView.animateWithDuration(0.8) { () -> Void in
            self.menuView?.alpha = 1
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        UIView.animateWithDuration(0.8) { () -> Void in
            self.menuView?.alpha = 1
        }
    }
}
