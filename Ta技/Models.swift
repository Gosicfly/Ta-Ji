//
//  Models.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/25.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import Foundation
import RealmSwift

class SubscriberInfo: Object {
    
    dynamic var userID: String = ""
    
    dynamic var userName: String = "Null"
    
    dynamic var signature: String = ""
    
    dynamic var avatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
    
}

class FansInfo: Object {
    
    dynamic var userID: String = ""
    
    dynamic var userName: String = "Null"
    
    dynamic var signature: String = ""
    
    dynamic var avatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
}

class StudentInfo: Object {
    
    dynamic var userID: String = ""
    
    dynamic var userName: String = "Null"
    
    dynamic var signature: String = ""
    
    dynamic var avatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
}

class TeacherInfo: Object {
    
    dynamic var userID: String = ""
    
    dynamic var userName: String = "Null"
    
    dynamic var signature: String = ""
    
    dynamic var avatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
}

class LabelInfo: Object {
    
    dynamic var id = ""
    
    dynamic var skill = ""
    
    dynamic var imageURL: String = ""
    
    override static func primaryKey() -> String? {
        return "skill"
    }
}

class SquareEventInfo: Object {
//    
//    "id:"1",
//    "userid":"1000",
//    "author":"1000",
//    "media":"http://taji.whutech.com/uploads/2016-03-18/56ec15efbc0a4.png",
//    "content":"测试动态111",
//    "tag":"足球",
//    "at":"1001.1002.1003",
//    "loc":"湖北省武汉市",
//    "mastercircle":"0",
//    "views":"5",
//    "forward":"0",
//    "like":"9",
//    "type":"image",
//    "time":"2016-04-03 22:09:58",
//    "username":"涂飞",
//    "avatar":"http://taji.whutech.com/uploads/tufei.jpg"
    
    dynamic var tid = ""
    
    dynamic var userid = ""
    
    dynamic var author = ""
    
    dynamic var authorname = ""
    
    dynamic var media = ""
    
    dynamic var content = ""
    
    dynamic var at = ""
    
    dynamic var loc = ""
    
    dynamic var mastercircle = ""
    
    dynamic var views = ""

    dynamic var forward = ""
    
    dynamic var likes = ""

    dynamic var type = ""

    dynamic var time_pub = ""

    dynamic var username = ""
    
    dynamic var avatar = ""
    
    dynamic var child = ""
    
    dynamic var video = "" // ""则为无视频
    
    dynamic var parent = ""
    
    dynamic var is_follow = false
    
    dynamic var is_liked = false
    
    override static func primaryKey() -> String? {
        return "tid"
    }
}

class PaintingEventInfo: SquareEventInfo {
    
}

class BannerInfo: Object {
    
    dynamic var id = ""
    
    dynamic var pic = "1"
    
    dynamic var url = ""
    
//    dynamic var time = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

struct UserInfo {
    
    var userid = ""
    
    var username = ""
    
    var avatar = ""
    
    var signature = ""
}
