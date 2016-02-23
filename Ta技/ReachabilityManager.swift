//
//  ReachabilityHelper.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/5.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import ReachabilitySwift

class ReachabilityManager {
    
    private static let reachability = try! Reachability.reachabilityForInternetConnection()
    
    private init() {}
    
    class func sharedManager() -> Reachability {
        return ReachabilityManager.reachability
    }
}
