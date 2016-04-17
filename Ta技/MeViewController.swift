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
    
    var skills = TAUtilsManager.userInfoManager.readSkill().characters.split(".").map { subSequence in
        return String(subSequence)
    }
    
    var interests = TAUtilsManager.userInfoManager.readInterest().characters.split(".").map { subSequence in
        return String(subSequence)
    }

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
    
    @IBOutlet weak var wantedSkillContainer: UICollectionView! {
        didSet {
            wantedSkillContainer.dataSource = self
            wantedSkillContainer.delegate = self
            wantedSkillContainer.registerClass(SkillCell.self, forCellWithReuseIdentifier: String(SkillCell))
        }
    }
    
    @IBOutlet weak var interestLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var ownedSkillContainer: UICollectionView! {
        didSet {
            ownedSkillContainer.dataSource = self
            ownedSkillContainer.delegate = self
            ownedSkillContainer.registerClass(SkillCell.self, forCellWithReuseIdentifier: String(SkillCell))
        }
    }
    
    @IBOutlet weak var skillLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var numberOfSkills: UILabel! {
        didSet {
            numberOfSkills.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            numberOfSkills.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var skillLabel: UILabel! {
        didSet {
            skillLabel.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            skillLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfStudents: UILabel! {
        didSet {
            numberOfStudents.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            numberOfStudents.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var studentLabel: UILabel! {
        didSet {
            studentLabel.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            studentLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfSubscribers: UILabel! {
        didSet {
            numberOfSubscribers.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            numberOfSubscribers.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var subscriberLabel: UILabel! {
        didSet {
            subscriberLabel.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            subscriberLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var numberOfFans: UILabel! {
        didSet {
            numberOfFans.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            numberOfFans.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var fansLabel: UILabel! {
        didSet {
            fansLabel.userInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MeViewController.pushAController(_:)))
            fansLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBAction func addLabel(sender: UIButton) {
        let addLabelController = LabelController(type: .Interest)
        self.navigationController?.pushViewController(addLabelController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setUserInfo()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.interestLayout.itemSize = CGSize(width: wantedSkillContainer.bounds.width / 4.5, height: wantedSkillContainer.bounds.height/1.05)
        self.skillLayout.itemSize = CGSize(width: wantedSkillContainer.bounds.width / 4.5, height: wantedSkillContainer.bounds.height/1.05)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.numberOfStudents.text = String(realm.objects(StudentInfo).count)
        self.numberOfSubscribers.text = String(realm.objects(SubscriberInfo).count)
        self.numberOfFans.text = String(realm.objects(FansInfo).count)
        Alamofire.request(.GET, "http://taji.whutech.com//Master/tudiList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                try! realm.write({ 
                    let infos = realm.objects(StudentInfo)
                    realm.delete(infos)
                })
                guard json["data"].type == .Array else {
                    self.numberOfStudents.text = "0"
                    return
                }
                self.numberOfStudents.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature: String
                    if subJson["signature"].type == .Null {
                        signature = defaultSignature
                    } else {
                        signature = subJson["signature"].string!
                    }
                    let avatarURL: String
                    if subJson["avatar"].type == .Null {
                        avatarURL = defaultAvatarURL
                    } else {
                        avatarURL = subJson["avatar"].string!
                    }
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
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                try! realm.write({
                    let infos = realm.objects(SubscriberInfo)
                    realm.delete(infos)
                })
                guard json["data"].type == .Array else {
                    self.numberOfSubscribers.text = "0"
                    return
                }
                self.numberOfSubscribers.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature: String
                    if subJson["signature"].type == .Null {
                        signature = defaultSignature
                    } else {
                        signature = subJson["signature"].string!
                    }
                    let avatarURL: String
                    if subJson["avatar"].type == .Null {
                        avatarURL = defaultAvatarURL
                    } else {
                        avatarURL = subJson["avatar"].string!
                    }
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
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                try! realm.write({
                    let infos = realm.objects(FansInfo)
                    realm.delete(infos)
                })
                guard json["data"].type == .Array else {
                    self.numberOfFans.text = "0"
                    return
                }
                self.numberOfFans.text = String(json["data"].array!.count)
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature: String
                    if subJson["signature"].type == .Null {
                        signature = defaultSignature
                    } else {
                        signature = subJson["signature"].string!
                    }
                    let avatarURL: String
                    if subJson["avatar"].type == .Null {
                        avatarURL = defaultAvatarURL
                    } else {
                        avatarURL = subJson["avatar"].string!
                    }
                    
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
        //选项卡相关数据请求
        Alamofire.request(.GET, "http://taji.whutech.com/Master/masterList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                return
            }
            let json = JSON(response.result.value!)
            if json["status"] == "200" {
                try! realm.write({
                    let infos = realm.objects(TeacherInfo)
                    realm.delete(infos)
                })
                guard json["data"].type == .Array else {
                    return
                }
                for (_, subJson) in json["data"] {
                    let userName: String
                    if subJson["username"].type == .Null {
                        userName = "Null"
                    } else {
                        userName = subJson["username"].string!
                    }
                    let userID = subJson["userid"].string!
                    let signature: String
                    if subJson["signature"].type == .Null {
                        signature = defaultSignature
                    } else {
                        signature = subJson["signature"].string!
                    }
                    let avatarURL: String
                    if subJson["avatar"].type == .Null {
                        avatarURL = defaultAvatarURL
                    } else {
                        avatarURL = subJson["avatar"].string!
                    }
                    
                    let teacherInfo = TeacherInfo()
                    teacherInfo.userID = userID
                    teacherInfo.userName = userName
                    teacherInfo.signature = signature
                    teacherInfo.avatarURL = avatarURL
                    try! realm.write({ () -> Void in
                        realm.add(teacherInfo, update: true)
                    })
                }
            }
        }
        //请求可添加的标签数据
        Alamofire.request(.GET, "http://taji.whutech.com/Skill/skill?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                if json["status"] == "200" {
                    try! realm.write({
                        let infos = realm.objects(LabelInfo)
                        realm.delete(infos)
                    })
                    guard json["data"].type == .Array else {
                        return
                    }
                    for (_, subJson) in json["data"] {
                        let id = subJson["id"].string!
                        let skill = subJson["skill"].string!
                        let imageURL = subJson["pic"].string!
                        
                        let info = LabelInfo()
                        info.id = id
                        info.skill = skill
                        info.imageURL = imageURL
                        try! realm.write({ () -> Void in
                            realm.add(info, update: true)
                        })
                    }
                }
            }
        }
        (UIApplication.sharedApplication().delegate as! AppDelegate).updateUserInfo()
        skills = TAUtilsManager.userInfoManager.readSkill().characters.split(".").map { subSequence in
            return String(subSequence)
        }
        
        interests = TAUtilsManager.userInfoManager.readInterest().characters.split(".").map { subSequence in
            return String(subSequence)
        }
        self.wantedSkillContainer.reloadData()
        self.ownedSkillContainer.reloadData()
    }
    
    func setUserInfo() {
        let avatarURL = TAUtilsManager.userInfoManager.readAvatarURL()
        let userName = TAUtilsManager.userInfoManager.readUserName()
//        let sex = TAUtilsManager.userInfoManager.readSex()
        self.avatar.kf_setImageWithURL(avatarURL, placeholderImage: Image(contentsOfFile: defaultAvatarURL))
        self.userName.text = userName
        self.signature.text = TAUtilsManager.userInfoManager.readSignature()
        self.school.text = TAUtilsManager.userInfoManager.readSchool()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "设置"), style: .Plain, target: self, action: #selector(MeViewController.settings))
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
        self.navigationController?.pushViewController(SettingsController(), animated: true)
    }
    
    func pushAController(gesture: UITapGestureRecognizer) {
        switch gesture.view! {
//        case self.skillLabel:
//            fallthrough
//        case self.numberOfSkills:
////            TO DO...
//            break
        case self.studentLabel:
            fallthrough
        case self.numberOfStudents:
            let studentsController = StudentsController()
            self.navigationController?.pushViewController(studentsController, animated: true)
        case self.subscriberLabel:
            fallthrough
        case self.numberOfSubscribers:
            let subscribeController = SubscribersController()
            self.navigationController?.pushViewController(subscribeController, animated: true)
        case self.fansLabel:
            fallthrough
        case self.numberOfFans:
            let fansController = FansController()
            self.navigationController?.pushViewController(fansController, animated: true)
        default:
            break
        }
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
            cell.picture.image = UIImage(named: "收藏")
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            break
        case (0, 1):
            self.navigationController?.pushViewController(TeachersController(), animated: true)
        case (1,0):
            break
        case (1, 1):
            break
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.wantedSkillContainer:
            return self.interests.count
        case self.ownedSkillContainer:
            return self.skills.count
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.wantedSkillContainer:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SkillCell), forIndexPath: indexPath) as! SkillCell
            cell.skillName = self.interests[indexPath.row]
            cell.skillLabel.backgroundColor = UIColor(red: 144/255, green: 92/255, blue: 152/255, alpha: 1)
            return cell
        case self.ownedSkillContainer:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SkillCell), forIndexPath: indexPath) as! SkillCell
            cell.skillName = self.skills[indexPath.row]
            cell.skillLabel.backgroundColor = UIColor(red: 20/255, green: 139/255, blue: 136/255, alpha: 1)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.wantedSkillContainer {
            let labelController = LabelController(type: .Interest)
            self.navigationController?.pushViewController(labelController, animated: true)
        } else {
            let labelController = LabelController(type: .Skill)
            self.navigationController?.pushViewController(labelController, animated: true)
        }
        return
    }
}
