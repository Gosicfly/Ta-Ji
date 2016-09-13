//
//  DetailViewController.swift
//  Ta技
//
//  Created by Gosicfly on 16/9/13.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UIViewController, TANavigationBarType {

    @IBOutlet weak var avatar: UIImageView! {
        didSet {
            avatar.image = avatarImage
        }
    }
    
    var avatarImage = UIImage()
    
    @IBOutlet weak var name: UILabel! {
        didSet {
            name.text = nameText
        }
    }
    
    var nameText = ""
    
    @IBOutlet weak var picture: UIImageView! {
        didSet {
            picture.image = pictureImage
        }
    }
    
    var pictureImage = UIImage()
    
    @IBOutlet weak var text: UILabel! {
        didSet {
            text.text = textText
        }
    }
    
    var  textText = ""
    
    @IBOutlet weak var favor: UIImageView! {
        didSet {
            favor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.addFavor)))
            favor.userInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var favorNumber: UILabel! {
        didSet {
            favorNumber.text = favorNumberText
        }
    }
    
    var favorNumberText = "0"
    
    @IBOutlet weak var comment: UIImageView! {
        didSet {
            comment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.addComment)))
            comment.userInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var zhuanfa: UIImageView! {
        didSet {
            zhuanfa.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.zhuanfaAction)))
            zhuanfa.userInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        self.title = "详情"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.masksToBounds = true
    }
    
    // MARK: -Selector
    func addFavor() {
        let value = Int(self.favorNumber.text!)
        self.favorNumber.text = self.favor.highlighted ? String(value!-1) : String(value!+1)
        self.favor.highlighted = !self.favor.highlighted
    }
    
    func addComment() {
        SVProgressHUD.showErrorWithStatus("服务器繁忙，请稍后再试")
    }
    
    func zhuanfaAction() {
        SVProgressHUD.showErrorWithStatus("服务器繁忙，请稍后再试")
    }

}
