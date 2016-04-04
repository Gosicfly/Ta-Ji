//
//  Protocols.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

protocol ItemSelectable: class {
    
    var selectedItem: UIView! { get set }
}

protocol HomeTitleViewDelegate: class {
    
    func transition(fromeViewController fromeViewController: UIViewController, toViewController: UIViewController)
}

protocol TANavigationBarType: class {
    
    func setNavigationBar()
}

protocol TATableViewType: class {
    
    var tableView: UITableView! { get set }
}

protocol TACollectionViewType: class {
    
    var collectionView: UICollectionView! { get set }
}

// 提供默认下拉刷新动作
protocol TARefreshable: class {
    
    var currentMaxPage: Int { get set }
    
    func setHeaderWithRefreshingBlock(block: (() -> Void)?)
    
    func setfooterWithRefreshingBlock(block: (() -> Void)?)
//
//    func beginRefreshing()
}