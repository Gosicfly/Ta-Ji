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
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CircleCell)) as! CircleCell
        return cell
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section != 0 else {
            return 0
        }
        return 5
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 225/255, green: 222/255, blue: 230/255, alpha: 1)
        return view
    }
}
