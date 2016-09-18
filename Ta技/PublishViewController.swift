//
//  PublishViewController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/13.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PublishViewController: UIViewController, TANavigationBarType {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            self.textView.text = "说点什么吧..."
            self.textView.backgroundColor = textViewBackgroundColor
            self.textView.layer.cornerRadius = 7
            self.textView.layer.masksToBounds = true
            self.textView.delegate = self
        }
    }
    
    @IBOutlet weak var hintOne: UILabel! {
        didSet {
            self.hintOne.textColor  = defaultTintColot
        }
    }
    
    @IBOutlet weak var hintTwo: UILabel! {
        didSet {
            self.hintTwo.textColor = defaultTintColot
        }
    }
    @IBOutlet weak var wechatImageView: UIImageView!
    
    @IBOutlet weak var weiboImageView: UIImageView!
    
    @IBOutlet weak var shituquanImageView: UIImageView! {
        didSet {
            self.shituquanImageView.userInteractionEnabled = true
            self.shituquanImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.shituquanTap)))
        }
    }
    
    @IBOutlet weak var pickerButton: UIButton! {
        didSet {
            pickerButton.addTarget(self, action: #selector(PublishViewController.setPicture), forControlEvents: .TouchUpInside)
        }
    }
    
    // 封面图片
    @IBOutlet weak var coverPicture: UIImageView!
    
    @IBOutlet weak var upload: UIButton! {
        didSet {
//            upload.layer.cornerRadius = upload.frame.height / 2 - 2
        }
    }
    
    @IBAction func upload(sender: AnyObject) {
        SVProgressHUD.showWithStatus("上传中")
        
        let data = UIImageJPEGRepresentation(self.coverPicture.image!, 1.0)!
        (UIApplication.sharedApplication().delegate as! AppDelegate).mediaService?.uploadByData(data, space: "taji-ios", fileName: String(arc4random_uniform(99999999)), dir: "/taji", progress: nil, success: { (uploadSession, returnURL) in
            
            Alamofire.request(.POST, "http://api.tajiapp.cn/DongTai/publish", parameters:
                [
                    "userid" : UserInfoManager.sharedManager().readID().0,
                    "openid" : UserInfoManager.sharedManager().readID().1,
                    "media" : returnURL,
                    "vedio" : "",
                    "content" : self.textView.text,
                    "parent" : "绘画",
                    "child" : "素描",
                    "loc" : "湖北省武汉市",
                    "mastercircle" : self.shituquanImageView.highlighted ? "1" : "0",
                ]).responseJSON(completionHandler: { (response) in
                    guard response.result.isSuccess else {
                        SVProgressHUD.showErrorWithStatus(response.result.error!.localizedDescription)
                        return
                    }
                    let json = JSON(response.result.value!)
                    print(json)
                    if json["status"].string! == "200" {
                        SVProgressHUD.showSuccessWithStatus("上传成功")
                        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(self.dismiss), userInfo: nil, repeats: false)
                    } else {
                        SVProgressHUD.showErrorWithStatus(json["msg"].string!)
                    }
                })
            }, failed: { (uploadSession, info) in
                SVProgressHUD.showErrorWithStatus("上传失败")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }

    func setNavigationBar() {
        self.title = "发布技能"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: #selector(PublishViewController.dismiss))
        let button = UIButton(type: .Custom)
        button.setAttributedTitle(NSAttributedString(string: "草稿箱", attributes: [NSForegroundColorAttributeName: defaultTintColot, NSFontAttributeName: UIFont.systemFontOfSize(14)]), forState: .Normal)
        button.setImage(UIImage(named: "icon_tab_publish_delete"), forState: .Normal)
        button.addTarget(self, action: #selector(PublishViewController.dismiss), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        let rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // MARK: - Private Method
    @objc private func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Selector
    @objc private func setPicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @objc private func shituquanTap() {
        self.shituquanImageView.highlighted = !self.shituquanImageView.highlighted
    }
}

// MARK: - UITextViewDelegate
extension PublishViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "说点什么吧..." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            textView.text = "说点什么吧..."
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
        }
        return true
    }
}

// MARK: - touchesBegan
extension PublishViewController {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textView.endEditing(true)
    }
}

extension PublishViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.coverPicture.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
