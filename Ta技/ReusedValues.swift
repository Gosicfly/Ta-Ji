//
//  ReusedValues.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import RealmSwift

let selectedColor = UIColor(red: 48/255, green: 250/255, blue: 205/255, alpha: 1)

let navigationBarColor = UIColor(red: 94/255, green: 64/255, blue: 114/255, alpha: 1)

let tabBarColor = UIColor(red: 67/255, green: 56/255, blue: 85/255, alpha: 1)

let bottomViewColor = UIColor(red: 80/255, green: 235/255, blue: 165/255, alpha: 1)

let defaultTintColot = UIColor(red: 204/255, green: 205/255, blue: 206/255, alpha: 1)

let defaultBackgroundColor = UIColor(red: 78/255, green: 60/255, blue: 101/255, alpha: 1)

let defaultTextColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)

let messageTextColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)

let textViewBackgroundColor = UIColor(red: 122/255, green: 109/255, blue: 133/255, alpha: 1)

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

let SCREEN_HEIGTH = UIScreen.mainScreen().bounds.height

let SCREEN_SIZE = UIScreen.mainScreen().bounds.size

let SCREEN_BOUNDS = UIScreen.mainScreen().bounds

let SCREEN_CENTER = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGTH / 2)

let appKey = "pkfcgjstfb228"

let realm = try! Realm()

let defaultSignature = "这家伙比较懒，什么都没说"

let defaultAvatarURL = NSBundle.mainBundle().pathForResource("no_avatar", ofType: ".png")!


