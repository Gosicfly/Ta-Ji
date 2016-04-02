//
//  ImageSelectedView.swift
//  Ta技
//
//  Created by Gosicfly on 16/4/1.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class ImageSelectedView: UIView {

    var imageView: UIImageView
    
    let checkMark = UIImageView()
    
    var selected: Bool = false {
        didSet {
            if self.selected {
                self.checkMark.highlighted = true
            } else {
                self.checkMark.highlighted = false
            }
        }
    }
    
    init(image: UIImage, selected: Bool = false) {
        self.imageView = UIImageView(image: image)
        self.selected = selected
        super.init(frame: CGRect.zero)
        self.imageView.addObserver(self, forKeyPath: "highlighted", options: [.New, .Old], context: nil)
    }
    
    private func setSubviews () {
        self.addSubview(self.imageView)
        self.imageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(self)
        }
        self.addSubview(self.checkMark)
        self.checkMark.snp_makeConstraints { (make) in
            make.centerX.equalTo(self).multipliedBy(1.7)
            make.centerY.equalTo(self).multipliedBy(0.3)
            make.width.equalTo(self).multipliedBy(0.3)
            make.height.equalTo(self).multipliedBy(0.3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMoveToSuperview(newSuperview: UIView?) {
        
    }
    
    override func layoutSubviews() {
        layoutIfNeeded()
        self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 8
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "highlighted" {
            let selected = change![NSKeyValueChangeNewKey]!.boolValue
            self.selected = selected
        }
    }
}
