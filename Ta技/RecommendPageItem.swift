//
//  RecommendPageItem.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/19.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

enum RecommendPageItemType {
    
    case Hot
    case Mine
}

class RecommendPageItem: UICollectionViewCell {
    
    var type: RecommendPageItemType = .Hot
    
    var tableView: UITableView! {
        didSet {
            self.contentView.addSubview(tableView)
            tableView.registerNib(UINib(nibName: "CircleCell", bundle: nil), forCellReuseIdentifier: String(CircleCell))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.backgroundColor = UIColor(red: 225/255, green: 222/255, blue: 230/255, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.tableView.bounds = self.contentView.bounds
        self.tableView.center = self.contentView.center
    }
    
    // MARK: -private method
    private func setSubviews() {
        self.tableView = UITableView(frame: CGRect.zero, style: .Plain)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension RecommendPageItem: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch self.type {
        case .Hot:
            return 1
        case .Mine:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.type {
        case .Hot:
            return 10
        case .Mine:
            switch section {
            case 0:
                return 3
            default:
                return 2
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CircleCell)) as! CircleCell
        return cell
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard self.type == .Mine && section == 1 else {
            return 0
        }
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.type == .Mine else {
            return nil
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70))
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "你可能感兴趣的小组"
        title.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        title.font = UIFont.systemFontOfSize(12)
        title.textAlignment = .Left
        headerView.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headerView).offset(10)
            make.centerY.equalTo(headerView).offset(10)
        }
        return headerView
    }
    
}
