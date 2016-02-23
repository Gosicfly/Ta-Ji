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
    
    // 主框架控制器
    static let tabBarController = TATabBarController()
    
    // 登陆视图控制器
    static let loginController = LoginController()
    
    // 搜索视图控制器
    static let searchController = SearchController()
    
}

