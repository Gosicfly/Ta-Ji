//
//  GFCycleScrollView.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/6.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher
import SwiftyJSON
import SnapKit
import ReachabilitySwift
import RealmSwift

/// 无限轮播图
class GFCycleScrollView: UICollectionReusableView {
    
    var bannerInfos: Results<BannerInfo>
    
    var collectionView: UICollectionView! {
        didSet {
            self.collectionView.registerClass(GFCycleScrollViewCell.self, forCellWithReuseIdentifier: String(GFCycleScrollViewCell))
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.pagingEnabled = true
            self.collectionView.showsHorizontalScrollIndicator = false
            self.addSubview(self.collectionView)
        }
    }
    
    var layout: UICollectionViewFlowLayout! {
        didSet {
            self.layout.scrollDirection = .Horizontal
            self.layout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 0
        }
    }
    
    var timer: NSTimer! {
        didSet {
            NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        }
    }
    
    var pageControl: UIPageControl! {
        didSet {
            self.pageControl.currentPage = 0
            self.addSubview(self.pageControl)
            self.pageControl.snp_makeConstraints { (make) -> Void in
                make.bottom.equalTo(self).offset(-8)
                make.height.equalTo(10)
                make.centerX.equalTo(self)
            }
        }
    }
    
    override init(frame: CGRect) {
        self.bannerInfos = realm.objects(BannerInfo)
        super.init(frame: frame)
        self.setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        self.layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.layout)
        self.pageControl = UIPageControl()
        self.timer = NSTimer(timeInterval: 3.4, target: self, selector: #selector(GFCycleScrollView.scrollImages), userInfo: nil, repeats: true)
    }
    
    override func layoutSubviews() {
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: .Left, animated: false)
        self.pageControl.numberOfPages = self.bannerInfos.count
    }
    
    func scrollImages() {
        guard self.bannerInfos.count > 0 else {
            return
        }
        let contentOffsetX = self.collectionView.contentOffset.x
        let currentRow = contentOffsetX / SCREEN_WIDTH
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(currentRow) + 1, inSection: 0), atScrollPosition: .Left, animated: true)
    }
    
}

extension GFCycleScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerInfos.count + 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(GFCycleScrollViewCell), forIndexPath: indexPath) as! GFCycleScrollViewCell
        guard self.bannerInfos.count > 0 else {
            return cell
        }
        switch indexPath.row {
        case 0:
            cell.imageView.kf_setImageWithURL(self.bannerInfos.last!.pic.convertToURL()!)
        case self.bannerInfos.count + 1:
            cell.imageView.kf_setImageWithURL(self.bannerInfos.first!.pic.convertToURL()!)
        default:
            cell.imageView.kf_setImageWithURL(self.bannerInfos[indexPath.row - 1].pic.convertToURL()!)
        }
        return cell
    }
}

extension GFCycleScrollView: UIScrollViewDelegate {
    
    //这个地方有一个Bug，就是当极快速的连续滑动时不能顺利的无线轮播；还有一个不算Bug，就是当图片数组只有一个元素的时候，会出现黑边，只要加个逻辑判断，稍后加
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let selectedItem = scrollView.contentOffset.x / SCREEN_WIDTH
        if selectedItem == CGFloat(self.bannerInfos.count + 1) {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: .Left, animated: false)
            self.pageControl.currentPage = 0
        } else if selectedItem == 0 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: self.bannerInfos.count, inSection: 0), atScrollPosition: .Left, animated: false)
            self.pageControl.currentPage = self.bannerInfos.count - 1
        } else {
            self.pageControl.currentPage = Int(selectedItem) - 1
        }
    }
    
    //拖曳时暂停定时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer.fireDate = NSDate.distantFuture()
    }
    
    //拖曳结束重启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.timer.fireDate = NSDate(timeIntervalSinceNow: self.timer.timeInterval)
    }
    
}