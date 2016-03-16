//
//  PasswordInputController.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/30.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import CryptoSwift

class PasswordInputController: UIViewController, TANavigationBarType, UIGestureRecognizerDelegate {
    
    private let reachability = ReachabilityManager.sharedManager()
    
    var mobile = ""
    
    var code = ""
    //TODO
    //增加左滑返回功能
    var passwordInputField: UITextField! {
        didSet {
            self.view.addSubview(self.passwordInputField)
            self.passwordInputField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.view).offset(120)
                make.height.equalTo(40)
            }
            self.passwordInputField.secureTextEntry = true
            self.passwordInputField.borderStyle = .RoundedRect
            self.passwordInputField.clearButtonMode = .WhileEditing
            self.passwordInputField.returnKeyType = .Done
            self.passwordInputField.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.passwordInputField.delegate = self
            self.passwordInputField.placeholder = "输入密码"
            performSelector(Selector("becomeFirstResponderAfterSecond"), withObject: nil, afterDelay: 0.6)
        }
    }
    
    var confirmInputField: UITextField! {
        didSet {
            self.view.addSubview(self.confirmInputField)
            self.confirmInputField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.passwordInputField.snp_bottom).offset(10)
                make.height.equalTo(40)
            }
            self.confirmInputField.secureTextEntry = true
            self.confirmInputField.borderStyle = .RoundedRect
            self.confirmInputField.clearButtonMode = .WhileEditing
            self.confirmInputField.returnKeyType = .Done
            self.confirmInputField.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.confirmInputField.delegate = self
            self.confirmInputField.placeholder = "再次确认"
        }
    }
    
    var nextButton: UIButton! {
        didSet {
            self.view.addSubview(nextButton)
            self.nextButton.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.confirmInputField.snp_bottom).offset(10)
                make.height.equalTo(35)
            }
            self.nextButton.layer.cornerRadius = 5
            self.nextButton.backgroundColor = navigationBarColor
            self.nextButton.tintColor = defaultTintColot
            self.nextButton.setTitle("注册", forState: .Normal)
            self.nextButton.addTarget(self, action: Selector("next"), forControlEvents: .TouchUpInside)
        }
    }
    
    var hint: UILabel! {
        didSet {
            self.view.addSubview(self.hint)
            self.hint.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.nextButton.snp_bottom).offset(5)
                make.height.equalTo(20)
            }
            self.hint.backgroundColor = UIColor.clearColor()
            self.hint.textAlignment = .Center
            self.hint.font = UIFont.systemFontOfSize(13)
            self.hint.adjustsFontSizeToFitWidth = true
            self.hint.text = "点击注册按钮即代表接受用户协议"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225/255, green: 223/255, blue: 231/255, alpha: 1)
        self.setNavigationBar()
        self.setSubViews()
    }
    
    /**
     viewDidLoad()调用过一段时间弹出键盘
     */
    func becomeFirstResponderAfterSecond() {
        self.passwordInputField.becomeFirstResponder()
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: defaultTintColot]
        self.navigationItem.title = "设置密码"
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        //左滑返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setSubViews() {
        self.passwordInputField = UITextField()
        self.confirmInputField = UITextField()
        self.nextButton = UIButton(type: .System)
        self.hint = UILabel()
    }
    
    func next() {
        SVProgressHUD.show()
        guard self.passwordInputField.text == self.confirmInputField.text else {
            SVProgressHUD.showErrorWithStatus("输入密码不一致")
            return
        }
        let password = self.passwordInputField.text!.md5()
        print(password)
        switch self.reachability.isReachable() {
        case true:
            self.view.endEditing(true)
            Alamofire.request(.GET, "http://taji.whutech.com/User/register?mobile=\(mobile)&code=\(code)&password=\(password)").responseJSON(completionHandler: { response in
                let json = JSON(response.result.value!)
                debugPrint(json)
                guard json["status"].string! == "200" else {
                    SVProgressHUD.showErrorWithStatus("用户已存在")
                    self.performSelector(Selector("dismiss"), withObject: nil, afterDelay: 0.5)
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    Alamofire.request(.GET, "http://taji.whutech.com/user/login?mobile=\(self.mobile)&password=\(password)").responseJSON(completionHandler: { (response) -> Void in
                        guard response.result.value != nil else {
                            SVProgressHUD.showErrorWithStatus("请检查网络状况")
                            return
                        }
                        var json = JSON(response.result.value!)
                        guard json["status"].string! == "200" else {
                            let errorInfo = json["msg"].string!
                            SVProgressHUD.showErrorWithStatus(errorInfo)
                            return
                        }
                        let userInfoManager = TAUtilsManager.userInfoManager
                        userInfoManager.writeloginState(true)
                        let (userID, openID) = (json["data"]["userid"].string!, json["data"]["openid"].string!)
                        userInfoManager.writeID(userid: userID, openid: openID)
                        if json["data"]["username"].type == .Null {
                            userInfoManager.writeUserName("Null")
                        } else {
                            userInfoManager.writeUserName(json["data"]["username"].string!)
                        }
                        if json["data"]["sex"].type == .Null {
                            userInfoManager.writeSex("男")
                        } else {
                            userInfoManager.writeSex(json["data"]["sex"].string!)
                        }
                        userInfoManager.writeMobile(json["data"]["mobile"].string!)
                        userInfoManager.writeAvatarURL(NSURL(string: json["data"]["avatar"].string!)!)
                        userInfoManager.synchronize()
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            Alamofire.request(.GET, "http://taji.whutech.com/user/userinfo?userid=\(userID)&openid=\(openID)").responseJSON { (response) -> Void in
                                json = JSON(response.result.value!)
                                TAUtilsManager.userInfoManager.writeRcToken(json["data"]["rcToken"].string!)
                                if json["data"]["school"].type == .Null {
                                    TAUtilsManager.userInfoManager.writeSchool("Null")
                                } else {
                                    TAUtilsManager.userInfoManager.writeSchool(json["data"]["school"].string!)
                                }
                                TAUtilsManager.userInfoManager.writeSignature(json["data"]["signature"].string!)
                                TAUtilsManager.userInfoManager.synchronize()
                                self.dismiss()
                                UIApplication.sharedApplication().windows[0].rootViewController = TATabBarController()
                            }
                        })
                    })
                })
            })
        case false:
            SVProgressHUD.showErrorWithStatus("无网络连接")
        }

    }
    
    func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension PasswordInputController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.passwordInputField:
            self.confirmInputField.becomeFirstResponder()
        case self.confirmInputField:
            self.confirmInputField.resignFirstResponder()
            self.next()
        default:
            break
        }
        return true
    }
}
