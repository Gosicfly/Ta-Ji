//
//  TASManager.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import Foundation

class TAUtilsManager {
    
    private init() {}
    
    static let userInfoManager = UserInfoManager.sharedManager()
    
    static let reachabilityManager = ReachabilityManager.sharedManager()
}

class TAVCManager {
    
    private init() {}
    
    static func resetAllControllers() {
//        TAVCManager.tabBarController = TATabBarController()
        TAVCManager.loginController = LoginController()
        TAVCManager.searchController = SearchController()
    }
    
    // 主框架控制器
//    private(set) static var tabBarController = TATabBarController()
    
    // 登陆视图控制器
    private(set) static var loginController = LoginController()
    
    // 搜索视图控制器
    private(set) static var searchController = SearchController()
    
}

