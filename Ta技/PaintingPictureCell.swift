//
//  PaintingPictureCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm

class ConcernButton: UIButton {
    //动态所对应的用户id
    var uid = ""
}

class PaintingPictureCell: UICollectionViewCell, HotCellItem {
    
    var favorNumber = "0"
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var concernButton: ConcernButton!

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var text: UILabel!
    
    /**
     点击关注按钮
     
     - parameter sender: 触发的按钮
     */
    @IBAction func concern(sender: ConcernButton) {
        if concernButton.titleLabel!.text!.containsString("+关注") {
            Alamofire.request(.GET, "http://api.tajiapp.cn/Follow/follow?userid=\(UserInfoManager.sharedManager().readID().0)&openid=\(UserInfoManager.sharedManager().readID().1)&uid=\(sender.uid)").responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("请检查网络")
                    return
                }
                let json = JSON(response.result.value!)
                guard json["status"].string! == "200" else {
                    return
                }
                let addedInfo = SubscriberInfo()
                addedInfo.userID = sender.uid
                addedInfo.userName = self.name.text!
                try! realm.write({ () -> Void in
                    realm.add(addedInfo, update: true)
                })
                print(json)
                sender.titleLabel?.text = " 已关注 "
                sender.setTitle(" 已关注 ", forState: .Normal)
                sender.sizeToFit()
                sender.setNeedsDisplay()
            }
        } else {
            Alamofire.request(.GET, "http://api.tajiapp.cn/follow/Unfollow?userid=\(UserInfoManager.sharedManager().readID().0)&openid=\(UserInfoManager.sharedManager().readID().1)&uid=\(sender.uid)").responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("请检查网络")
                    return
                }
                let json = JSON(response.result.value!)
                guard json["status"].string! == "200" else {
                    return
                }
                let addedInfo = SubscriberInfo()
                addedInfo.userID = sender.uid
                addedInfo.userName = self.name.text!
                try! realm.write({ () -> Void in
                    realm.delete(realm.objects(SubscriberInfo).filter("userID = '\(sender.uid)'"))
                })
                print(json)
                sender.titleLabel?.text = " +关注 "
                sender.setTitle(" +关注 ", forState: .Normal)
                sender.sizeToFit()
                sender.setNeedsDisplay()
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatar.layer.cornerRadius = self.avatar.bounds.height / 2
        self.avatar.layer.masksToBounds = true
        
        self.concernButton.layer.cornerRadius = self.concernButton.bounds.height / 2
        self.concernButton.layer.borderColor = UIColor(red: 66/255, green: 255/255, blue: 209/255, alpha: 1).CGColor
        self.concernButton.layer.borderWidth = 1
        
        let infos = realm.objects(SubscriberInfo)
        var isExist = false
        infos.forEach { (info) in
            if self.concernButton.uid == info.userID {
                isExist = true
            }
        }
        switch isExist {
        case true:
            concernButton.setTitle(" 已关注 ", forState: .Normal)
            concernButton.titleLabel?.sizeToFit()
        case false:
            concernButton.setTitle(" +关注 ", forState: .Normal)
            concernButton.titleLabel?.sizeToFit()
        }
    }
}
