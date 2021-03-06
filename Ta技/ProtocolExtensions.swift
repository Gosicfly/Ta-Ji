//
//  ProtocolExtensions.swift
//  Ta技
//
//  Created by Gosicfly on 16/3/18.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import Foundation
import MJRefresh

extension TARefreshable where Self: TATableViewType {
    
    func setHeaderWithRefreshingBlock(block: (() -> Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            if let block = block {
                block()
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
            } else {
                debugPrint("refresh")
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
            }
        })
        header.lastUpdatedTimeLabel?.hidden = true
        self.tableView.mj_header = header
    }
    
    func setfooterWithRefreshingBlock(block: (() -> Void)?) {
        
    }
}

extension TARefreshable where Self: TACollectionViewType {
    
    func setHeaderWithRefreshingBlock(block: (() -> Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            if let block = block {
                block()
            } else {
                debugPrint("refresh")
                self.collectionView.reloadData()
                self.collectionView.mj_header.endRefreshing()
            }
        })
        header.arrowView?.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        header.activityIndicatorViewStyle = .White
        header.stateLabel?.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        header.lastUpdatedTimeLabel?.hidden = true
        self.collectionView.mj_header = header
    }
    
    func setfooterWithRefreshingBlock(block: (() -> Void)?) {
        let footer = MJRefreshAutoNormalFooter { 
            if let block = block {
                block()
            } else {
                debugPrint("footerRefresh")
                self.collectionView.reloadData()
                self.collectionView.mj_header.endRefreshing()
            }
        }
        footer.automaticallyRefresh = false
        footer.activityIndicatorViewStyle = .White
        footer.stateLabel?.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        self.collectionView.mj_footer = footer
    }
}