//
//  TelInputController.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//
//http://taji.whutech.com/register?phone=17072750175&code=原文&password=MD5
//http://taji.whutech.com/sms.php?phone=手机号

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import ReachabilitySwift
import CryptoSwift

class TelInputController: UIViewController, TANavigationBarType {
    
    var telInputField: UITextField! {
        didSet {
            self.view.addSubview(telInputField)
            //设置约束
            self.telInputField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.view).offset(120)
                make.height.equalTo(30)
            }
            self.telInputField.keyboardType = .PhonePad
            self.telInputField.borderStyle = .RoundedRect
            self.telInputField.leftViewMode = .Always
            let leftView = TelLeftView(frame: CGRect(x: 0, y: 0, width: 52, height: 30), areaCode: "+86")
            self.telInputField.leftView = leftView
            self.telInputField.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.telInputField.clearButtonMode = .WhileEditing
//            self.telInputField.
            self.telInputField.becomeFirstResponder()
        }
    }
    
    var nextButton: UIButton! {
        didSet {
            self.view.addSubview(nextButton)
            self.nextButton.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.telInputField.snp_bottom).offset(10)
                make.height.equalTo(30)
            }
            self.nextButton.layer.cornerRadius = 5
            self.nextButton.backgroundColor = navigationBarColor
            self.nextButton.tintColor = defaultTintColot
            self.nextButton.setTitle("继续", forState: .Normal)
            self.nextButton.addTarget(self, action: Selector("next"), forControlEvents: .TouchUpInside)
        }
    }
    
    var signInButton: UIButton! {
        didSet {
            self.view.addSubview(self.signInButton)
            self.signInButton.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.nextButton.snp_bottom).offset(10)
                make.height.equalTo(30)
            }
            self.signInButton.backgroundColor = UIColor.clearColor()
            self.signInButton.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.signInButton.setTitle("已有账号登录", forState: .Normal)
            self.signInButton.addTarget(self, action: Selector(""), forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225/255, green: 223/255, blue: 231/255, alpha: 1)
        self.setNavigationBar()
        self.setSubViews()
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: defaultTintColot]
        self.navigationItem.title = "你的手机号"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: Selector("cancel"))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: Selector("cancel"))
        
    }
    
    private func setSubViews() {
        self.telInputField = UITextField()
        self.nextButton = UIButton(type: .System)
        self.signInButton = UIButton(type: .System)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func next() {
//        let phoneNumber = self.telInputField.text!
//        Alamofire.request(.GET, "http://taji.whutech.com/sms.php?phone=\(phoneNumber)").responseJSON { (response) -> Void in
//            //TODO
//            //ReachabilitySwift 联网测试
//            let json = JSON(response.result.value!)
//            print(json)
//            guard json["status"].string! == "200" else {
//                return
//            }
//        }
        let vc = CodeInputController()
        vc.telNumber = self.telInputField.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    func cancel() {
        print("tellinput")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.telInputField.resignFirstResponder()
    }
}