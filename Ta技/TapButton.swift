//
//  TapButton.swift
//  Ta技
//
//  Created by Gosicfly on 16/4/3.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class TapButton: UIView {
    
    var tapClosure: () -> Void

    init(frame: CGRect, image: UIImage, title: String, tapClosure: () -> Void) {
        self.tapClosure = tapClosure
        super.init(frame: frame)
        let imageView = UIImageView(image: image)
        imageView.center = self.center
        imageView.center.y -= self.bounds.height / 8
        imageView.bounds.size = CGSize(width: self.frame.width/1.6, height: self.frame.width/1.6)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap)))
        self.addSubview(imageView)
        let label = UILabel()
        label.text = title
        label.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = .Center
        label.center = self.center
        label.center.y += self.bounds.height / 3
        label.bounds.size = CGSize(width: self.frame.width, height: self.frame.width/1.5)
        self.addSubview(label)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tap() {
        tapClosure()
    }

}
