//
//  LoginController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/22.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CryptoSwift

class LoginController: UIViewController {
    
    private let reachability = TAUtilsManager.reachabilityManager

    @IBOutlet weak var userNameInput: UITextField! {
        didSet {
            userNameInput.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var passwordInput: UITextField! {
        didSet {
            passwordInput.delegate = self
            passwordInput.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var signIn: UIButton!
    
    @IBOutlet weak var forgetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTargets()
    }

    private func addTargets() {
        signUp.addTarget(self, action: #selector(LoginController.buttonTaped(_:)), forControlEvents: .TouchUpInside)
        signIn.addTarget(self, action: #selector(LoginController.buttonTaped(_:)), forControlEvents: .TouchUpInside)
    }
    
    // MARK : - Selector
    func buttonTaped(button: UIButton!) {
        switch button {
        case signUp:
            let telInputController = UINavigationController(rootViewController: TelInputController())
            telInputController.modalTransitionStyle = .CrossDissolve
            self.presentViewController(telInputController, animated: true, completion: nil)
        case signIn:
            self.view.endEditing(true)
            SVProgressHUD.show()
            guard self.reachability.isReachable() == true else {
                SVProgressHUD.showErrorWithStatus("无网络连接")
                return
            }
            let mobile = userNameInput.text!
            let password = passwordInput.text!.md5()
            Alamofire.request(.GET, "http://taji.whutech.com/user/login?mobile=\(mobile)&password=\(password)").responseJSON(completionHandler: { (response) -> Void in
                guard response.result.value != nil else {
                    SVProgressHUD.showErrorWithStatus("请检查网络状况")
                    return
                }
                var json = JSON(response.result.value!)
                guard json["status"].string! == "200" else {
                    let errorInfo = json["msg"].string!
                    SVProgressHUD.showErrorWithStatus(errorInfo)
                    if errorInfo.containsString("用户") {
                        self.userNameInput.becomeFirstResponder()
                    } else {
                        self.passwordInput.becomeFirstResponder()
                    }
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
                        print(json)
                        TAUtilsManager.userInfoManager.writeRcToken(json["data"]["rcToken"].string!)
                        if json["data"]["school"].type == .Null {
                            TAUtilsManager.userInfoManager.writeSchool("Null")
                        } else {
                            TAUtilsManager.userInfoManager.writeSchool(json["data"]["school"].string!)
                        }
                        if json["data"]["skill"].type == .Null {
                            
                        } else {
                            TAUtilsManager.userInfoManager.writeSkill(json["data"]["skill"].string!)
                        }
                        if json["data"]["interest"].type == .Null {
                            
                        } else {
                            TAUtilsManager.userInfoManager.writeInterest(json["data"]["interest"].string!)
                        }
                        TAUtilsManager.userInfoManager.writeSignature(json["data"]["signature"].string!)
                        TAUtilsManager.userInfoManager.synchronize()
                        self.performSelector(#selector(LoginController.dismissHUD), withObject: nil, afterDelay: 0.5)
                        UIApplication.sharedApplication().windows[0].rootViewController = TAVCManager.tabBarController
                    }
                })
            })
        default:
            break
        }
    }
    
    func signInEvent() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        userNameInput.borderStyle = .None
        let maskPath1 = UIBezierPath(roundedRect: userNameInput.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.CGPath
        userNameInput.layer.mask = maskLayer1
        
        passwordInput.borderStyle = .None
        let maskPath2 = UIBezierPath(roundedRect: passwordInput.bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = maskPath2.CGPath
        passwordInput.layer.mask = maskLayer2
        
        let separatorPath = UIBezierPath()
        separatorPath.moveToPoint(CGPoint(x: 0, y: userNameInput.frame.size.height))
        separatorPath.addLineToPoint(CGPoint(x: userNameInput.frame.size.width, y: userNameInput.frame.size.height))
        let separatorLayer = CAShapeLayer()
        separatorLayer.path = separatorPath.CGPath
        separatorLayer.strokeColor = UIColor.grayColor().CGColor
        separatorLayer.lineWidth = 0.5
        userNameInput.layer.addSublayer(separatorLayer)
        
        //设置按钮圆角
        signUp.layer.cornerRadius = signUp.frame.height / 4
        signUp.layer.masksToBounds = true
        signIn.layer.cornerRadius = signIn.frame.height / 4
        signIn.layer.masksToBounds = true
    }
    
    func dismissHUD() {
        SVProgressHUD.dismiss()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.passwordInput:
            self.buttonTaped(self.signIn)
        default:
            break
        }
        return true
    }
}
