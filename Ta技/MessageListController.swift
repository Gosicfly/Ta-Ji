//
//  MessageListController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/24.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit

class MessageListController: RCConversationListViewController, TANavigationBarType {
    
    var tableHeaderView: UIView! {
        didSet {
            self.conversationListTableView.tableHeaderView = tableHeaderView
            tableHeaderView.backgroundColor = UIColor(red: 80/255, green: 60/255, blue: 101/255, alpha: 1)
            //添加图标
            let atButton = UIButton()
            atButton.setImage(UIImage(named: "icon_tab_message_at"), forState: .Normal)
            tableHeaderView.addSubview(atButton)
            atButton.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(0.35)
                make.centerY.equalTo(tableHeaderView).multipliedBy(0.72)
            }
            let commentButton = UIButton()
            commentButton.setImage(UIImage(named: "icon_tab_message_comment"), forState: .Normal)
            tableHeaderView.addSubview(commentButton)
            commentButton.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(1)
                make.centerY.equalTo(tableHeaderView).multipliedBy(0.72)
            }
            let favorButton = UIButton()
            favorButton.setImage(UIImage(named: "icon_tab_message_favor"), forState: .Normal)
            tableHeaderView.addSubview(favorButton)
            favorButton.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(1.65)
                make.centerY.equalTo(tableHeaderView).multipliedBy(0.72)
            }
            //添加标签
            let atLabel = UILabel()
            tableHeaderView.addSubview(atLabel)
            atLabel.font = UIFont.systemFontOfSize(12)
            atLabel.textColor = defaultTextColor
            atLabel.text = "提到我的"
            atLabel.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(0.35)
                make.centerY.equalTo(tableHeaderView).multipliedBy(1.42)
            }
            let commentLabel = UILabel()
            commentLabel.font = UIFont.systemFontOfSize(12)
            tableHeaderView.addSubview(commentLabel)
            commentLabel.textColor = defaultTextColor
            commentLabel.text = "评论"
            commentLabel.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(1)
                make.centerY.equalTo(tableHeaderView).multipliedBy(1.42)
            }
            let favorLabel = UILabel()
            favorLabel.font = UIFont.systemFontOfSize(12)
            tableHeaderView.addSubview(favorLabel)
            favorLabel.textColor = defaultTextColor
            favorLabel.text = "赞"
            favorLabel.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(tableHeaderView).multipliedBy(1.65)
                make.centerY.equalTo(tableHeaderView).multipliedBy(1.42)
            }
        }
    }

    override func viewDidLoad() {
        //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
        super.viewDidLoad()
        self.setNavigationBar()
        self.setSubViews()
        self.setRongCloud()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "聊天", style: .Plain, target: self, action: Selector(""))
    }
    
    func setRongCloud() {
        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue,
            RCConversationType.ConversationType_DISCUSSION.rawValue,
            RCConversationType.ConversationType_CHATROOM.rawValue,
            RCConversationType.ConversationType_GROUP.rawValue,
            RCConversationType.ConversationType_APPSERVICE.rawValue,
            RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue,
            RCConversationType.ConversationType_GROUP.rawValue])
        self.emptyConversationView = UIView()
        self.conversationListTableView.tableFooterView = UIView()
        self.conversationListTableView.bounces = false
    }
    
    func setSubViews() {
        // heaView的frame必须在初始化的时候设置，不然的话会遮挡住tableViewCell
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGTH * 0.16))
    }
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        //打开会话界面
        let chat = MessageController(conversationType: model.conversationType, targetId: model.targetId)
        chat.title = model.conversationTitle
//        chat.defaultInputType = .Text
        chat.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chat, animated: true)
    }
    
    
}
