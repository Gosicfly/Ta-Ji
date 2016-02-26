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

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            searchBar.tintColor = navigationBarColor
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.bounces = false
            tableView.tableFooterView = UIView()
        }
    }
    
//    lazy var searchController: UISearchController = {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        return searchController
//    }()
    
    weak var menuView: UICollectionView?
    
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
        print(1)
        self.endEditing(true)
    }
}

extension SearchPageItem: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
