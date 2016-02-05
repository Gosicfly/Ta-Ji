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
