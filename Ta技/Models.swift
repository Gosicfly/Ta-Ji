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

struct UserInfo {
    
    var userid = ""
    
    var username = ""
    
    var avatar = ""
    
    var signature = ""
}
