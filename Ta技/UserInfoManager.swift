//
//  UserInfoManager.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

/*
"username": null,
"userid": "1010",
"openid": "2b135250be1f9e0428c3f5cdf64eecdf",
"sex": null,
"mobile": "1111111111",
"avatar": "http://taji.whutech.com/uploads/no_avatar.png"
*/

import Foundation

/// 这个类管理的是需要持久化的信息
final class UserInfoManager {
    
    // 私有单例
    private static let sharedInstance = UserInfoManager()
    
    // 返回单例
    class func sharedManager() -> UserInfoManager {
        return UserInfoManager.sharedInstance
    }
    
    /*------------------------------------------------------------*/
    private let defaultPlist = NSUserDefaults.standardUserDefaults()
    
    private init() {
        guard self.defaultPlist.boolForKey("alreadyExist") == false else {
            return
        }
        self.defaultPlist.setBool(true, forKey: "alreadyExist")
        self.defaultPlist.setBool(false, forKey: "loginState")
        self.defaultPlist.setValue("nil", forKey: "userName")
        self.defaultPlist.setValue("", forKey: "userid")
        self.defaultPlist.setValue("", forKey: "openid")
        self.defaultPlist.setValue("男", forKey: "sex")
        self.defaultPlist.setValue("", forKey: "mobile")
        self.defaultPlist.setURL(NSURL(string: "http://taji.whutech.com/uploads/no_avatar.png"), forKey: "avatarURL")
        self.defaultPlist.synchronize()
    }
    
    // MARK: - Write methods
    func writeloginState(state: Bool) {
        self.defaultPlist.setBool(state, forKey: "loginState")
    }
    
    func writeUserName(userName: String) {
        self.defaultPlist.setValue(userName, forKey: "userName")
    }
    
    func writeID(userid userid: String, openid: String) {
        self.defaultPlist.setValue(userid, forKey: "userid")
        self.defaultPlist.setValue(openid, forKey: "openid")
    }
    
    func writeSex(sex: String) {
        guard sex == "男" || sex == "女" else {
            fatalError("性别设置有误")
        }
        self.defaultPlist.setValue(sex, forKey: "sex")
    }
    
    func writeMobile(mobile: String) {
        self.defaultPlist.setValue(mobile, forKey: "mobile")
    }
    
    func writeAvatarURL(url: NSURL) {
        self.defaultPlist.setURL(url, forKey: "avatarURL")
    }
    
    func writeRcToken(rcToken: String) {
        //不知道这里要不要做对“\”的处理
//        rcToken.stringByReplacingOccurrencesOfString("\\", withString: "")
        self.defaultPlist.setValue(rcToken, forKey: "rcToken")
    }
    
    func writeSchool(school: String) {
        self.defaultPlist.setValue(school, forKey: "school")
    }
    
    // MARK: - Read methods
    func readloginState() -> Bool {
        return self.defaultPlist.boolForKey("loginState")
    }
    
    func readUserName() -> String {
        return self.defaultPlist.stringForKey("userName")!
    }
    
    func readID() -> (String, String) {
        return (self.defaultPlist.stringForKey("userid")!, self.defaultPlist.stringForKey("openid")!)
    }
    
    func readSex() -> String {
        return self.defaultPlist.stringForKey("sex")!
    }
    
    func readMobile() -> String {
        return self.defaultPlist.stringForKey("mobile")!
    }
    
    func readAvatarURL() -> NSURL {
        return self.defaultPlist.URLForKey("avatarURL")!
    }
    
    func readRcToken() -> String {
        return self.defaultPlist.stringForKey("rcToken")!
    }
    
    func readSchool() -> String {
        return self.defaultPlist.stringForKey("school")!
    }
    
    // - MARK: Delete Method
    func delete(key: String) {
        guard key != "alreadyExist" else {
            return
        }
        self.defaultPlist.removeObjectForKey(key)
    }
    
    // - MARK: Synchronize method
    func synchronize() {
        self.defaultPlist.synchronize()
    }
}

/// 这个类管理的是动态变化的，不需要持久化的信息数据
class UserDynamicInfo {
    
}