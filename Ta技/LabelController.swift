//
//  LabelController.swift
//  Ta技
//
//  Created by Gosicfly on 16/4/1.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher
import Alamofire
import SnapKit
import SVProgressHUD
import SwiftyJSON

enum LabelControllerType {
    case Interest
    case Skill
}

class LabelController: UIViewController, TANavigationBarType {
    
    var labelInfos: Results<LabelInfo>
    
    var selectedLabel: Set<String> = []
    
    var type: LabelControllerType
    
    var collectionView: UICollectionView! {
        didSet {
            self.view.addSubview(collectionView)
            collectionView.snp_makeConstraints { (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(self.view)
            }
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.bounces = true
            collectionView.allowsMultipleSelection = true
            collectionView.registerNib(UINib(nibName: String(LabelControllerCell), bundle: nil), forCellWithReuseIdentifier: String(LabelControllerCell))
            collectionView.backgroundColor = UIColor(red: 225/255, green: 222/255, blue: 230/255, alpha: 1)
        }
    }

    var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.scrollDirection = .Vertical
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 1
            layout.itemSize = CGSize(width: self.view.frame.width / 4.2, height: self.view.frame.width / 3)
        }
    }
    
    var button: UIButton! {
        didSet {
            self.view.addSubview(button)
            button.snp_makeConstraints { (make) in
                make.left.equalTo(self.view).offset(10)
                make.right.equalTo(self.view).offset(-10)
                make.bottom.equalTo(self.view).offset(-10)
                make.height.equalTo(40)
            }
            button.setTitle("选择你感兴趣的技能(\(self.selectedLabel.count)/5)", forState: .Normal)
            if self.type == .Skill {
                button.setTitle("选择你掌握的技能(\(self.selectedLabel.count)/5)", forState: .Normal)
            }
            button.titleLabel?.textAlignment = .Center
            button.addTarget(self, action: #selector(self.submit), forControlEvents: .TouchUpInside)
            button.titleLabel?.textColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.backgroundColor = UIColor(red: 97/225, green: 62/255, blue: 117/255, alpha: 1)
            button.layer.cornerRadius = 5
        }
    }
    
    init(type: LabelControllerType) {
        self.type = type
        self.labelInfos = realm.objects(LabelInfo)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubviews()
        self.setNavigationBar()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        KingfisherManager.sharedManager.cache.clearMemoryCache()
    }
    
    private func setSubviews() {
        self.layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.layout)
        self.button = UIButton()
    }
    
    func setNavigationBar() {
        if self.type == .Interest {
            self.title = "选择你感兴趣的技能"
        } else if self.type == .Skill {
            self.title = "选择你掌握的技能"
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: #selector(LabelController.back))
    }
    
    // MARK: - Selector
    @objc private func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func submit() {
        guard self.selectedLabel.count <= 5 else {
            SVProgressHUD.showErrorWithStatus("选择过多\n请重新选择")
            return
        }
        switch self.type {
        case .Interest:
            var arr = [String]()
            for name in self.selectedLabel {
                arr.append(name)
            }
            var string = arr.reduce("", combine: {
                $0 + "." + $1
            })
            string = string.substringFromIndex(string.startIndex.advancedBy(1))
            print("http://api.tajiapp.cn/Skill/intadskill?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&interest=\(string.convertToUTF8()!)&skill=\(TAUtilsManager.userInfoManager.readSkill().convertToUTF8()!)")
            Alamofire.request(.GET, "http://api.tajiapp.cn/Skill/intadskill?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&interest=\(string.convertToUTF8()!)&skill=\(TAUtilsManager.userInfoManager.readSkill().convertToUTF8()!)").responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    return
                }
                let json = JSON(response.result.value!)
                print(json)
                if json["status"] == "200" {
                    SVProgressHUD.showSuccessWithStatus(json["msg"].string!)
                }
                if json["status"] == "-1" {
                    SVProgressHUD.showErrorWithStatus(json["msg"].string!)
                }
            })
        case .Skill:
            var arr = [String]()
            for name in self.selectedLabel {
                arr.append(name)
            }
            let string = arr.reduce("", combine: {
                $0 + "." + $1
            })
            Alamofire.request(.GET, "http://api.tajiapp.cn/Skill/intadskill?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&interest=\(TAUtilsManager.userInfoManager.readInterest().convertToUTF8()!)&skill=\(string.convertToUTF8()!)").responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    return
                }
                let json = JSON(response.result.value!)
                if json["status"] == "200" {
                    SVProgressHUD.showSuccessWithStatus(json["msg"].string!)
                }
                if json["status"] == "-1" {
                    SVProgressHUD.showErrorWithStatus(json["msg"].string!)
                }
            })
        }
        
    }
}

extension LabelController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.labelInfos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(LabelControllerCell), forIndexPath: indexPath) as! LabelControllerCell
        cell.skill.text = self.labelInfos[indexPath.row].skill
        cell.imageView.kf_setImageWithURL(self.labelInfos[indexPath.row].imageURL.convertToURL()!)
        return cell
    }
    
    // MARK: - TO FIX
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let skillName = (collectionView.cellForItemAtIndexPath(indexPath) as! LabelControllerCell).skill.text!
        
        if self.selectedLabel.contains(skillName) == true {
            self.selectedLabel.remove(skillName)
        } else {
            self.selectedLabel.insert(skillName)
        }
        if self.type == .Interest {
            button.setTitle("选择你感兴趣的技能(\(self.selectedLabel.count)/5)", forState: .Normal)
        } else {
            button.setTitle("选择你掌握的技能(\(self.selectedLabel.count)/5)", forState: .Normal)
        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
