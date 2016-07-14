//
//  HotPageCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/6.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Kingfisher

enum HotPageItemType {
    case Square
    case Painting
}

class HotPageItem: UICollectionViewCell, TACollectionViewType, TARefreshable {
    
    var type: HotPageItemType = .Square
    
    private var squareEventInfos = realm.objects(SquareEventInfo)
    
    private var paintingEventInfos = realm.objects(PaintingEventInfo)
    
    var currentMaxPage: Int = 1
    
    var layout: UICollectionViewFlowLayout! {
        didSet {
            self.layout.scrollDirection = .Vertical
        }
    }
    
    var collectionView: UICollectionView! {
        didSet {
            self.contentView.addSubview(self.collectionView)
            self.collectionView.registerClass(SquareCell.self, forCellWithReuseIdentifier: String(SquareCell))
            self.collectionView.registerNib(UINib(nibName: String(PaintingPictureCell), bundle: nil), forCellWithReuseIdentifier: String(PaintingPictureCell))
            self.collectionView.registerClass(GFCycleScrollView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(GFCycleScrollView))
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.backgroundColor = defaultBackgroundColor
        }
    }
    
    var collectionViewHeader: GFCycleScrollView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubViews()
        self.setHeaderWithRefreshingBlock { 
            self.fetchData(1, count: 20, header: true, clear: true)
        }
        self.setfooterWithRefreshingBlock {
            self.fetchData(self.currentMaxPage, count: 20, header: false, clear: false)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.collectionView.bounds = self.contentView.bounds
        self.collectionView.center = self.contentView.center
        switch type {
        case .Square:
            self.layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGTH / 4.6)
            self.layout.itemSize = CGSize(width: SCREEN_WIDTH / 2, height: SCREEN_HEIGTH / 3)
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 0
        default:
            self.layout.headerReferenceSize = CGSize.zero
            self.layout.itemSize = CGSize(width: SCREEN_WIDTH / 1.03, height: SCREEN_HEIGTH / 1.5)
            self.layout.minimumInteritemSpacing = 10
            self.layout.minimumLineSpacing = 10
        }
    }
    
    override func didMoveToWindow() {
        if realm.objects(BannerInfo).count == 0 {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(300 * NSEC_PER_MSEC))
            dispatch_after(delayTime, dispatch_get_main_queue(), {
                self.collectionView.mj_header.beginRefreshing()
            })
        }
    }
    
    func fetchData(page: Int, count: Int, header: Bool, clear: Bool) {
        if header {
            self.currentMaxPage = 1
            Alamofire.request(.GET, "http://api.tajiapp.cn/DongTai/Banner?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("请检查网络")
                    return
                }
                let json = JSON(response.result.value!)
                guard json["status"].string! == "200" && json["data"].array!.count >= 2 else {
                    return
                }
                try! realm.write({
                    realm.delete(realm.objects(BannerInfo))
                })
                for (id, subJson) in json["data"] {
//                    let id = subJson["id"].string!
                    let pic = subJson["pic"].string!
                    let url = subJson["url"].string!
//                    let time = subJson["time"].string!
                    
                    let info = BannerInfo()
                    info.id = id
                    info.pic = pic
                    info.url = url
//                    info.time = time
                    try! realm.write({
                        realm.add(info, update: true)
                    })
                }
                self.collectionViewHeader?.collectionView.reloadData()
            })
        } else {
            self.currentMaxPage += 1
        }
        Alamofire.request(.GET, "http://api.tajiapp.cn/DongTai?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&page=\(self.currentMaxPage)&count=\(count)").responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("请检查网络")
                return
            }
            let json = JSON(response.result.value!)
            guard json["status"].string! == "200" else {
                return
            }
            if clear {
                try! realm.write({ 
                    realm.delete(realm.objects(SquareEventInfo))
                    self.currentMaxPage = 1
                })
                self.collectionView.mj_footer.resetNoMoreData()
            }
            for (_, subJson) in json["data"] {
                let tid = subJson["tid"].string!
                let userid = subJson["userid"].string!
                let authorname = subJson["authorname"].string!
                let media = subJson["media"].string!
                let content = subJson["content"].string!
                let at = subJson["at"].string!
                let loc = subJson["loc"].string!
                let mastercircle = subJson["mastercircle"].string!
                let views = subJson["views"].string!
                let forward = subJson["forward"].string!
                let likes = subJson["likes"].string!
                let type = subJson["type"].string!
                let time_pub = subJson["time_pub"].string!
                let username = subJson["username"].string!
                let avatar = subJson["avatar"].string!
                
                let info = SquareEventInfo()
                info.tid = tid
                info.userid = userid
                info.authorname = authorname
                info.media = media
                info.content = content
                info.at = at
                info.loc = loc
                info.mastercircle = mastercircle
                info.views = views
                info.forward = forward
                info.likes = likes
                info.type = type
                info.time_pub = time_pub
                info.username = username
                info.avatar = avatar
                
                try! realm.write({ () -> Void in
                    realm.add(info, update: true)
                })
            }
            self.squareEventInfos = realm.objects(SquareEventInfo)
            if self.type == .Square {
                self.collectionView.reloadData()
                self.collectionViewHeader?.collectionView.reloadData()
                if header {
                    self.collectionView.mj_header.endRefreshing()
                } else {
                    if json["data"].array!.count == count {
                        self.collectionView.mj_footer.endRefreshing()
                    } else {
                        self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
            }
        }
        
        Alamofire.request(.GET, "http://api.tajiapp.cn/DongTai?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&child=\("美妆".convertToUTF8()!)&page=\(self.currentMaxPage)&count=\(count)").responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("请检查网络")
                return
            }
            let json = JSON(response.result.value!)
            guard json["status"].string! == "200" && json["data"].array!.count >= 2 else {
                return
            }
            if clear {
                try! realm.write({
                    realm.delete(realm.objects(PaintingEventInfo))
                    self.currentMaxPage = 1
                })
                self.collectionView.mj_footer.resetNoMoreData()
            }
            for (_, subJson) in json["data"] {
                let tid = subJson["tid"].string!
                let userid = subJson["userid"].string!
                let authorname = subJson["authorname"].string!
                let media = subJson["media"].string!
                let content = subJson["content"].string!
                let at = subJson["at"].string!
                let loc = subJson["loc"].string!
                let mastercircle = subJson["mastercircle"].string!
                let views = subJson["views"].string!
                let forward = subJson["forward"].string!
                let likes = subJson["likes"].string!
                let type = subJson["type"].string!
                let time_pub = subJson["time_pub"].string!
                let username = subJson["username"].string!
                let avatar = subJson["avatar"].string!
                
                let info = PaintingEventInfo()
                info.tid = tid
                info.userid = userid
                info.authorname = authorname
                info.media = media
                info.content = content
                info.at = at
                info.loc = loc
                info.mastercircle = mastercircle
                info.views = views
                info.forward = forward
                info.likes = likes
                info.type = type
                info.time_pub = time_pub
                info.username = username
                info.avatar = avatar
                
                try! realm.write({ () -> Void in
                    realm.add(info, update: true)
                })
                self.paintingEventInfos = realm.objects(PaintingEventInfo)
                if self.type == .Painting {
                    self.collectionView.reloadData()
                    self.collectionViewHeader?.collectionView.reloadData()
                    if header {
                        self.collectionView.mj_header.endRefreshing()
                    } else {
                        if json["data"].array!.count == count {
                            self.collectionView.mj_footer.endRefreshing()
                        } else {
                            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                }
                
            }
        }
    }
    
    // MARK: - private methods
    private func setSubViews() {
        self.layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
    }
    
    override func prepareForReuse() {

    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HotPageItem: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch  self.type{
        case .Square:
            return self.squareEventInfos.count
        case .Painting:
            return self.paintingEventInfos.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch type {
        case .Square:
            let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(String(SquareCell), forIndexPath: indexPath) as! SquareCell
            let info = self.squareEventInfos[indexPath.row]
            cell.showImageView.kf_setImageWithURL(info.media.convertToURL()!)
            cell.avatarImageView.kf_setImageWithURL(info.avatar.convertToURL()!)
            cell.titleLabel.text = info.content
            cell.numberOfLikers.text = info.likes
            return cell
        case .Painting:
            let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(String(PaintingPictureCell), forIndexPath: indexPath) as! PaintingPictureCell
            let info = self.paintingEventInfos[indexPath.row]
            cell.avatar.kf_setImageWithURL(info.avatar.convertToURL()!)
            cell.name.text = info.username
            cell.picture.kf_setImageWithURL(info.media.convertToURL()!)
            cell.text.text = info.content
            cell.concernButton.uid = info.userid
            cell.layer.cornerRadius = cell.bounds.height / 70
            return cell
        }
        
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: String(GFCycleScrollView), forIndexPath: indexPath) as! GFCycleScrollView
        self.collectionViewHeader = view
        return view
    }
}




