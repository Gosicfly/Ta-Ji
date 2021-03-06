//
//  AppDelegate.swift
//  TA技
//
//  Created by Gosicfly on 16/1/18.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

// userID 1002
// openID b6850e695aee83b8e6f4eaef5d2bb172

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource {
    
    var window: UIWindow?
    
    var mediaService: ALBBMediaServiceProtocol?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: SCREEN_BOUNDS)
        self.window?.backgroundColor = navigationBarColor
        self.setDefalutNavigationBarStyle()
        if TAUtilsManager.userInfoManager.readloginState() == true {
            updateUserInfo()
            self.window?.rootViewController = TATabBarController()
        } else {
            self.window?.rootViewController = LoginController()
        }
        self.window?.makeKeyAndVisible()
        self.setRongCloudDataSource()
        
        //阿里百川SDK初始化
        ALBBSDK.sharedInstance().setDebugLogOpen(false)
        ALBBSDK.sharedInstance().asyncInit({ 
            print("ALBBSDK init success!")
            }, failure: { error in
                print("ALBBSDK init success!:\(error.description)")
        })
        self.mediaService = ALBBSDK.sharedInstance().getService(ALBBMediaServiceProtocol) as? ALBBMediaServiceProtocol
        return true
    }
    
    func setDefalutNavigationBarStyle() {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "导航栏渐变色")!)
        UINavigationBar.appearance().tintColor = defaultTintColot
        UINavigationBar.appearance().translucent = false
    }
    
    func setRongCloudDataSource() {
        RCIM.sharedRCIM().userInfoDataSource = self
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        Alamofire.request(.GET, "http://api.tajiapp.cn/user/getAvatar?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)&uid=\(userId)").responseJSON { (response) -> Void in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                userInfo.userId = json["data"]["uid"].string!
                if json["data"]["username"].type == .Null {
                    userInfo.name = "Null"
                } else {
                    userInfo.name = json["data"]["username"].string!
                }
                userInfo.portraitUri = json["data"]["avatar"].string!
                completion(userInfo)
            }
        }
    }
    
    func updateUserInfo() {
        Alamofire.request(.GET, "http://api.tajiapp.cn/user/userinfo?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                return
            }
            let json = JSON(response.result.value!)
            if json["data"]["rcToken"].type != .Null {
                TAUtilsManager.userInfoManager.writeRcToken(json["data"]["rcToken"].string!)
            }
            if json["data"]["school"].type == .Null {
                TAUtilsManager.userInfoManager.writeSchool("Null")
            } else {
                TAUtilsManager.userInfoManager.writeSchool(json["data"]["school"].string!)
            }
            if json["data"]["skill"].type == .Null {
                
            } else {
                TAUtilsManager.userInfoManager.writeSkill(json["data"]["skill"].string!)
            }
            if json["data"]["interest"].type == .Null {
                
            } else {
                TAUtilsManager.userInfoManager.writeInterest(json["data"]["interest"].string!)
            }
            if json["data"]["signature"].type == .Null {
                
            } else {
                TAUtilsManager.userInfoManager.writeSignature(json["data"]["signature"].string!)
            }
            TAUtilsManager.userInfoManager.synchronize()
        }
        
        //登录时获取一次订阅列表
        Alamofire.request(.GET, "http://api.tajiapp.cn/Follow/followList?userid=\(TAUtilsManager.userInfoManager.readID().0)&openid=\(TAUtilsManager.userInfoManager.readID().1)").responseJSON { (response) -> Void in
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
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

