//
//  HomeTitleView.swift
//  TA技
//
//  Created by Gosicfly on 16/1/21.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class HomeTitleView: UIView, ItemSelectable {
    
    weak var delegate: HomeTitleViewDelegate!
    
    let firstBtn = UIButton(type: .Custom)
    
    let secondBtn = UIButton(type: .Custom)
    
    let thirdBtn = UIButton(type: .Custom)
    
    var selectedItem: UIView! {
        didSet {
            (oldValue as! UIButton).selected = false
            (self.selectedItem as! UIButton).selected = true
        }
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width / 5 * 3.5, height: 40))
        self.firstBtn.frame = CGRect(x: 0, y: 0, width: self.frame.width / 3, height: 40)
        self.secondBtn.frame = CGRect(x: self.frame.width / 3, y: 0, width: self.frame.width / 3, height: 40)
        self.thirdBtn.frame = CGRect(x: self.frame.width / 3 * 2, y: 0, width: self.frame.width / 3, height: 40)
        
        self.firstBtn.setTitle("热门", forState: .Normal)
        self.secondBtn.setTitle("订阅", forState: .Normal)
        self.thirdBtn.setTitle("活动", forState: .Normal)
        
        self.firstBtn.setTitleColor(selectedColor, forState: UIControlState.Selected)
        self.secondBtn.setTitleColor(selectedColor, forState: UIControlState.Selected)
        self.thirdBtn.setTitleColor(selectedColor, forState: UIControlState.Selected)
        
        //another way to set title color when selected
        //        self.firstBtn.setAttributedTitle(NSAttributedString(string: "热门", attributes: [NSForegroundColorAttributeName: selectedColor]), forState: .Selected)
        //        self.secondBtn.setAttributedTitle(NSAttributedString(string: "关注", attributes: [NSForegroundColorAttributeName: selectedColor]), forState: .Selected)
        //        self.thirdBtn.setAttributedTitle(NSAttributedString(string: "广场", attributes: [NSForegroundColorAttributeName: selectedColor]), forState: .Selected)
        
        self.firstBtn.addTarget(self, action: #selector(HomeTitleView.btnSelect(_:)), forControlEvents: .TouchUpInside)
        self.secondBtn.addTarget(self, action: #selector(HomeTitleView.btnSelect(_:)), forControlEvents: .TouchUpInside)
        self.thirdBtn.addTarget(self, action: #selector(HomeTitleView.btnSelect(_:)), forControlEvents: .TouchUpInside)
        
        self.addSubview(firstBtn)
        self.addSubview(secondBtn)
        self.addSubview(thirdBtn)
        self.selectedItem = self.firstBtn
        self.firstBtn.selected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnSelect(button: UIButton) {
        if let delegate  = self.delegate as? BaseHomeController {
            guard button != self.selectedItem else {
                return
            }
            switch button {
            case self.firstBtn:
                delegate.nextChildViewController = delegate.hotViewController
            case self.secondBtn:
                delegate.nextChildViewController = delegate.concernViewController
            case self.thirdBtn:
                delegate.nextChildViewController = delegate.activityViewController
            default:
                break
            }
            delegate.transition(fromeViewController: delegate.currentChildViewController, toViewController: delegate.nextChildViewController)
            delegate.currentChildViewController = delegate.nextChildViewController
        }
        self.selectedItem = button
    }
    
}
