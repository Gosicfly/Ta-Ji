//
//  TATabBarController.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TATabBarController: UITabBarController {
    
    lazy private var centerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: SCREEN_WIDTH / 5 * 2, y: 0, width: SCREEN_WIDTH / 5, height: self.tabBar.bounds.height))
        button.setImage(UIImage(named: "icon_tab_center"), forState: .Normal)
        button.backgroundColor = UIColor(red: 142/255, green: 92/255, blue: 152/255, alpha: 1)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRectInset(button.bounds, -5, 1), cornerRadius: 0).CGPath
        button.addTarget(self, action: Selector("presentPublishViewController"), forControlEvents: .TouchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBar.translucent = false
        self.tabBar.tintColor = selectedColor
        self.tabBar.barTintColor = tabBarColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChildViewControllers()
        self.setRongCloudInfo()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addCenterButton()
    }
    
    func setChildViewControllers() {
        self.addChildViewController(BaseHomeController(), title: "首页", image: "icon_tab_home")
        self.addChildViewController(CircleViewController(), title: "圈子", image: "icon_tab_circle")
        self.addChildViewController(UIViewController())
        self.addChildViewController(MessageListController(), title: "消息", image: "icon_tab_message")
        self.addChildViewController(MeViewController(), title: "我的", image: "icon_tab_me")
    }
    
    func setRongCloudInfo() {
        RCIM.sharedRCIM().initWithAppKey(appKey)
        RCIM.sharedRCIM().connectWithToken(TAUtilsManager.userInfoManager.readRcToken(), success: { (userID) -> Void in
            print("登陆成功。当前登录的用户ID：\(userID)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }) { () -> Void in
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        }
        RCIM.sharedRCIM().globalConversationAvatarStyle = .USER_AVATAR_CYCLE
        RCIM.sharedRCIM().globalMessageAvatarStyle = .USER_AVATAR_CYCLE
        RCIM.sharedRCIM().currentUserInfo = RCUserInfo(userId: TAUtilsManager.userInfoManager.readID().0, name: TAUtilsManager.userInfoManager.readUserName(), portrait: TAUtilsManager.userInfoManager.readAvatarURL().absoluteString)
    }
    
    func addCenterButton() {
        self.tabBar.addSubview(self.centerButton)
    }
    
    func presentPublishViewController() {
        let publishViewController = PublishViewController()
        self.presentViewController(UINavigationController(rootViewController: publishViewController), animated: true, completion: nil)
    }
}
