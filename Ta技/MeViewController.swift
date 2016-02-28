//
//  MeViewController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/13.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire
import SwiftyJSON
import RealmSwift

class MeViewController: UIViewController, TANavigationBarType, UIGestureRecognizerDelegate {

    @IBOutlet weak var blurBackgroundImageView: UIImageView!
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var avatar: UIImageView! 
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var school: UILabel!
    
    @IBOutlet weak var signature: UILabel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = UIColor.clearColor()
            tableView.scrollEnabled = false
            tableView.separatorStyle = .None
            tableView.registerNib(UINib(nibName: "MeMenuCell", bundle: nil), forCellReuseIdentifier: String(MeMenuCell))
        }
    }
    
    @IBOutlet weak var numberOfSkills: UILabel! {
        didSet {
            numberOfSkills.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("pushAController:"))
            numberOfSkills.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfStudents: UILabel! {
        didSet {
            numberOfStudents.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("pushAController:"))
            numberOfStudents.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfSubscribers: UILabel! {
        didSet {
            numberOfSubscribers.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("pushAController:"))
            numberOfSubscribers.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfFans: UILabel! {
        didSet {
            numberOfFans.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("pushAController:"))
            numberOfFans.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBAction func addLabel(sender: UIButton) {
        let addLabelController = AddLabelController()
        self.navigationController?.pushViewController(addLabelController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setUserInfo()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Alamofire.request(.GET, "http://taji.whutech.com//Master/tudiList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                self.numberOfStudents.text = String(realm.objects(StudentInfo).count)
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                self.numberOfStudents.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature = subJson["signature"].string!
                    let avatarURL = subJson["avatar"].string!
                    
                    let studentInfo = StudentInfo()
                    studentInfo.userID = userID
                    studentInfo.userName = userName
                    studentInfo.signature = signature
                    studentInfo.avatarURL = avatarURL
                    try! realm.write({ () -> Void in
                        realm.add(studentInfo, update: true)
                    })
                }
            }
        }
        Alamofire.request(.GET, "http://taji.whutech.com/Follow/followList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                self.numberOfSubscribers.text = String(realm.objects(SubscriberInfo).count)
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                self.numberOfSubscribers.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature = subJson["signature"].string!
                    let avatarURL = subJson["avatar"].string!
                    
                    let subscriberInfo = SubscriberInfo()
                    subscriberInfo.userID = userID
                    subscriberInfo.userName = userName
                    subscriberInfo.signature = signature
                    subscriberInfo.avatarURL = avatarURL
                    try! realm.write({ () -> Void in
                        realm.add(subscriberInfo, update: true)
                    })
                }
            }
        }
        Alamofire.request(.GET, "http://taji.whutech.com/Follow/fansList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON(completionHandler: { (response) -> Void in
            guard response.result.isSuccess else {
                self.numberOfFans.text = String(realm.objects(FansInfo).count)
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                self.numberOfFans.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature = subJson["signature"].string!
                    let avatarURL = subJson["avatar"].string!
                    
                    let fansInfo = FansInfo()
                    fansInfo.userID = userID
                    fansInfo.userName = userName
                    fansInfo.signature = signature
                    fansInfo.avatarURL = avatarURL
                    try! realm.write({ () -> Void in
                        realm.add(fansInfo, update: true)
                    })
                }
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func setUserInfo() {
        let avatarURL = TAUtilsManager.userInfoManager.readAvatarURL()
        let userName = TAUtilsManager.userInfoManager.readUserName()
//        let sex = TAUtilsManager.userInfoManager.readSex()
        self.avatar.kf_setImageWithURL(avatarURL, placeholderImage: Image(named: "no_avatar"))
        self.userName.text = userName
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "设置"), style: .Plain, target: self, action: Selector("settings"))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.masksToBounds = true
    }
    
    // MARK: - Selector
    func settings() {
        
    }
    
    func pushAController(gesture: UITapGestureRecognizer) {
        switch gesture.view! {
        case self.numberOfSkills:
//            TO DO...
            break
        case self.numberOfStudents:
            let studentsController = StudentsController()
            self.navigationController?.pushViewController(studentsController, animated: true)
        case self.numberOfSubscribers:
            let subscribeController = SubscriberController()
            self.navigationController?.pushViewController(subscribeController, animated: true)
        case self.numberOfFans:
            let fansController = FansController()
            self.navigationController?.pushViewController(fansController, animated: true)
        default:
            break
        }
    }
    
    func pushSubscribeController() {
        let subscribeController = SubscriberController()
        self.navigationController?.pushViewController(subscribeController, animated: true)

    }
    
    func pushFansController() {
        let fansController = FansController()
        self.navigationController?.pushViewController(fansController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(MeMenuCell)) as! MeMenuCell
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.section = 0
            cell.row = 0
            cell.optionalHint.hidden = false
            cell.title.text = "师徒圈"
            cell.picture.image = UIImage(named: "徒")
        case (0, 1):
            cell.section = 0
            cell.row = 1
            cell.title.text = "我的师傅"
            cell.picture.image = UIImage(named: "师")
        case (1, 0):
            cell.section = 1
            cell.row = 0
            cell.title.text = "草稿箱"
            cell.picture.image = UIImage(named: "删除")
        case (1, 1):
            cell.section = 1
            cell.row = 1
            cell.title.text = "收藏"
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        default:
            return 15
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
}
