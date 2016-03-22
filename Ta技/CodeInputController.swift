//
//  CodeInputController.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class CodeInputController: UIViewController, TANavigationBarType, UIGestureRecognizerDelegate {
    
    private let reachability = ReachabilityManager.sharedManager()
    
    var i = 60
    
    var timer: NSTimer!
    
    var mobile: String = ""
    
    private var hintOne: UILabel! {
        didSet {
            self.view.addSubview(self.hintOne)
            self.hintOne.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.view).offset(60)
                make.height.equalTo(30)
            }
            self.hintOne.backgroundColor = UIColor.clearColor()
            self.hintOne.textColor = UIColor.blackColor()
            self.hintOne.textAlignment = .Center
            self.hintOne.font = UIFont.systemFontOfSize(19)
            self.hintOne.adjustsFontSizeToFitWidth = true
            self.hintOne.text = "你的手机号：\(self.mobile)"
        }
    }
    
    private var hintTwo: UILabel! {
        didSet {
            self.view.addSubview(self.hintTwo)
            self.hintTwo.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.hintOne.snp_bottom).offset(5)
                make.height.equalTo(20)
            }
            self.hintTwo.backgroundColor = UIColor.clearColor()
            self.hintTwo.textColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.hintTwo.textAlignment = .Center
            self.hintTwo.font = UIFont.systemFontOfSize(14)
            self.hintTwo.adjustsFontSizeToFitWidth = true
            self.hintTwo.text = "短信验证码已发送到你的手机，快看看吧"
        }
    }
    
    private var codeInputField: TATextField! {
        didSet {
            self.view.addSubview(self.codeInputField)
            self.codeInputField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.hintTwo.snp_bottom).offset(10)
                make.height.equalTo(40)
            }
//            self.codeInputField.textAlignment = .Center
            self.codeInputField.backgroundColor = UIColor.whiteColor()
            self.codeInputField.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
            self.codeInputField.layer.cornerRadius = 5
            self.codeInputField.clearButtonMode = .WhileEditing
            self.codeInputField.autocorrectionType = .No
            self.codeInputField.spellCheckingType = .No
            self.codeInputField.returnKeyType = .Done
            self.codeInputField.keyboardType = .NumberPad
            self.codeInputField.delegate = self
            self.codeInputField.placeholder = "输入短信验证码"
            //这个地方console会输出一个警告，不明白是为什么
            performSelector(#selector(CodeInputController.becomeFirstResponderAfterSecond), withObject: nil, afterDelay: 0.6)
        }
    }
    
    private var requestAgainButton: UIButton! {
        didSet {
            self.view.addSubview(self.requestAgainButton)
            self.requestAgainButton.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.codeInputField.snp_bottom).offset(10)
                make.height.equalTo(35)
            }
            self.requestAgainButton.backgroundColor  = UIColor.clearColor()
            self.requestAgainButton.layer.cornerRadius = 5
            self.requestAgainButton.layer.borderWidth = 1.5
            self.requestAgainButton.layer.borderColor = navigationBarColor.CGColor
            self.requestAgainButton.tintColor = navigationBarColor
            self.requestAgainButton.enabled = false
            self.requestAgainButton.setTitle("重新获取(\(self.i)秒)", forState: .Disabled)
            self.requestAgainButton.setTitle("重新获取", forState: .Normal)
            self.requestAgainButton.addTarget(self, action: #selector(CodeInputController.requestAgain), forControlEvents: .TouchUpInside)
        }
    }
    
    private var nextButton: UIButton! {
        didSet {
            self.view.addSubview(self.nextButton)
            self.nextButton.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.view).offset(40)
                make.right.equalTo(self.view).offset(-40)
                make.top.equalTo(self.requestAgainButton.snp_bottom).offset(10)
                make.height.equalTo(35)
            }
            self.nextButton.backgroundColor = navigationBarColor
            self.nextButton.layer.cornerRadius = 5
            self.nextButton.tintColor = defaultTintColot
            self.nextButton.setTitle("继续", forState: .Normal)
            self.nextButton.addTarget(self, action: #selector(CodeInputController.next), forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225/255, green: 223/255, blue: 231/255, alpha: 1)
        self.setNavigationBar()
        self.setSubViews()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CodeInputController.oneMinute), userInfo: nil, repeats: true)
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: defaultTintColot]
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: #selector(CodeInputController.back))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.title = "短信验证"
        //左滑返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    func setSubViews() {
        self.hintOne = UILabel()
        self.hintTwo = UILabel()
        self.codeInputField = TATextField(frame: CGRectZero, edgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        self.requestAgainButton = UIButton(type: .System)
        self.nextButton = UIButton(type: .System)
    }
    
    func oneMinute() {
        self.i -= 1
        if self.i != 0 {
            self.requestAgainButton.titleLabel?.text = "重新获取(\(self.i)秒)"
            self.requestAgainButton.setTitle("重新获取(\(self.i)秒)", forState: .Disabled)
        } else {
            self.timer.invalidate()
            self.requestAgainButton.enabled = true
            
        }
    }
    
    func next() {
        SVProgressHUD.show()
        switch self.reachability.isReachable() {
        case true:
            let code = self.codeInputField.text!.uppercaseString
            Alamofire.request(.GET, "http://taji.whutech.com/Sms/verify_code?mobile=\(self.mobile)&code=\(code)").responseJSON(completionHandler: { response in
                let json = JSON(response.result.value!)
                print(json)
                guard json["status"].string! == "200" else {
                    SVProgressHUD.showErrorWithStatus(json["msg"].string!)
                    self.performSelector(#selector(CodeInputController.dismiss), withObject: nil, afterDelay: 0.5)
                    self.performSelector(#selector(CodeInputController.becomeFirstResponderAfterSecond), withObject: nil, afterDelay: 0.6)
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismiss()
                    self.codeInputField.endEditing(true)
                    let passwordInputController = PasswordInputController()
                    passwordInputController.mobile = self.mobile
                    passwordInputController.code = code
                    self.navigationController?.pushViewController(passwordInputController, animated: true)
                })
            })
        case false:
            SVProgressHUD.showErrorWithStatus("无网络连接")
        }
    }
    
    //TODO
    func requestAgain() {
        
    }
    
    func becomeFirstResponderAfterSecond() {
        self.codeInputField.becomeFirstResponder()
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
        self.codeInputField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension CodeInputController: UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.next()
        return true
    }
}