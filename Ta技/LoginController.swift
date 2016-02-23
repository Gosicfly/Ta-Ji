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
    
    private let reachability = ReachabilityManager.sharedManager()

    @IBOutlet weak var userInput: UITextField! {
        didSet {
            userInput.tintColor = UIColor(red: 166/255, green: 104/255, blue: 175/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var passwordInput: UITextField! {
        didSet {
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
        signUp.addTarget(self, action: Selector("buttonTaped:"), forControlEvents: .TouchUpInside)
        signIn.addTarget(self, action: Selector("buttonTaped:"), forControlEvents: .TouchUpInside)
    }
    
    // MARK : - Selector
    func buttonTaped(button: UIButton!) {
        switch button {
        case signUp:
            let telInputController = UINavigationController(rootViewController: TelInputController())
            telInputController.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(telInputController, animated: true, completion: nil)
        case signIn:
            SVProgressHUD.show()
            guard self.reachability.isReachable() == true else {
                SVProgressHUD.showErrorWithStatus("无网络连接")
                return
            }
            let mobile = userInput.text!
            let password = passwordInput.text!.md5()
            Alamofire.request(.GET, "http://taji.whutech.com/user/login?mobile=\(mobile)&password=\(password)").responseJSON(completionHandler: { (response) -> Void in
                guard response.result.value != nil else {
                    SVProgressHUD.showErrorWithStatus("请检查网络状况")
                    return
                }
                let json = JSON(response.result.value!)
                print(json)
                guard json["status"].string! == "200" else {
                    let errorInfo = json["msg"].string!
                    SVProgressHUD.showErrorWithStatus(errorInfo)
                    return
                }
            })
        default:
            break
        }
    }
    
    func signInEvent() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        userInput.borderStyle = .None
        let maskPath1 = UIBezierPath(roundedRect: userInput.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.CGPath
        userInput.layer.mask = maskLayer1
        
        passwordInput.borderStyle = .None
        let maskPath2 = UIBezierPath(roundedRect: passwordInput.bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = maskPath2.CGPath
        passwordInput.layer.mask = maskLayer2
        
        let separatorPath = UIBezierPath()
        separatorPath.moveToPoint(CGPoint(x: 0, y: userInput.frame.size.height))
        separatorPath.addLineToPoint(CGPoint(x: userInput.frame.size.width, y: userInput.frame.size.height))
        let separatorLayer = CAShapeLayer()
        separatorLayer.path = separatorPath.CGPath
        separatorLayer.strokeColor = UIColor.grayColor().CGColor
        separatorLayer.lineWidth = 0.5
        userInput.layer.addSublayer(separatorLayer)
        
        //设置按钮圆角
        signUp.layer.cornerRadius = signUp.frame.height / 4
        signUp.layer.masksToBounds = true
        signIn.layer.cornerRadius = signIn.frame.height / 4
        signIn.layer.masksToBounds = true
    }
}
