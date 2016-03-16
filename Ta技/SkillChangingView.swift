//
//  SkillChangingView.swift
//  Ta技
//
//  Created by Gosicfly on 16/3/15.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit
import SnapKit

class SkillChangingView: UIView {
    
    private var firstSkill: UILabel! {
        didSet {
            if firstSkill != nil {
                firstSkill.textAlignment = .Center
                firstSkill.textColor = UIColor(red: 155/255, green: 100/255, blue: 165/255, alpha: 1)
                self.addSubview(firstSkill)
                firstSkill.snp_makeConstraints { (make) -> Void in
                    make.left.equalTo(self)
                    make.right.equalTo(self).offset(-self.frame.width / 2)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                }
            }
        }
    }
    
    private var secondSkill: UILabel! {
        didSet {
            if secondSkill != nil {
                secondSkill.textAlignment = .Center
                secondSkill.textColor = UIColor(red: 155/255, green: 100/255, blue: 165/255, alpha: 1)
                self.addSubview(secondSkill)
                secondSkill.snp_makeConstraints { (make) -> Void in
                    make.left.equalTo(self).offset(self.frame.width / 2)
                    make.right.equalTo(self)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                }
            }
        }
    }
    
    var firstSkillName: String {
        get {
            return self.firstSkill.text!
        }
        set {
            self.firstSkill.text = newValue
        }
    }
    
    var secondSkillName: String {
        get {
            return self.secondSkill.text!
        }
        set {
            self.secondSkill.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: self.center.x / 7, y: 0))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 6, y: 0))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7 * 8, y: self.frame.size.height), controlPoint1: CGPoint(x: self.center.x / 7 * 6.9, y: self.frame.size.height / 10), controlPoint2: CGPoint(x: self.center.x / 7 * 7.1, y: self.frame.size.height / 10 * 9))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 13, y: self.frame.size.height))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7 * 13, y: 0), controlPoint1: CGPoint(x: self.frame.width, y: self.center.y / 3 * 5), controlPoint2: CGPoint(x: self.frame.width, y: self.center.y / 3))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 8, y: 0))
        path.moveToPoint(CGPoint(x: self.center.x / 7, y: 0))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7, y: self.frame.size.height), controlPoint1: CGPoint(x: 0, y: self.center.y / 3), controlPoint2: CGPoint(x: 0, y: self.center.y / 3 * 5))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 6, y: self.frame.size.height))
        path.moveToPoint(CGPoint(x: self.center.x / 7 * 6, y: self.frame.size.height))
        path.addQuadCurveToPoint(CGPoint(x: self.center.x / 7 * 6.8, y: self.center.y), controlPoint: CGPoint(x: self.center.x / 7 * 6.5, y: self.frame.size.height / 10 * 9))
        path.moveToPoint(CGPoint(x: self.center.x / 7 * 8, y: 0))
        path.addQuadCurveToPoint(CGPoint(x: self.center.x / 7 * 7.2, y: self.center.y), controlPoint: CGPoint(x: self.center.x / 7 * 7.5, y: self.frame.size.height / 10))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor(red: 80/255, green: 60/255, blue: 102/255, alpha: 1).CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 1
        self.layer.addSublayer(shapeLayer)
        self.setSubViews()
        self.setSkills("123", secondSkill: "whut")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor()
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: self.center.x / 7, y: 0))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 6, y: 0))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7 * 8, y: self.frame.size.height), controlPoint1: CGPoint(x: self.center.x / 7 * 6.9, y: self.frame.size.height / 10), controlPoint2: CGPoint(x: self.center.x / 7 * 7.1, y: self.frame.size.height / 10 * 9))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 13, y: self.frame.size.height))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7 * 13, y: 0), controlPoint1: CGPoint(x: self.frame.width, y: self.center.y / 3 * 5), controlPoint2: CGPoint(x: self.frame.width, y: self.center.y / 3))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 8, y: 0))
        path.moveToPoint(CGPoint(x: self.center.x / 7, y: 0))
        path.addCurveToPoint(CGPoint(x: self.center.x / 7, y: self.frame.size.height), controlPoint1: CGPoint(x: 0, y: self.center.y / 3), controlPoint2: CGPoint(x: 0, y: self.center.y / 3 * 5))
        path.addLineToPoint(CGPoint(x: self.center.x / 7 * 6, y: self.frame.size.height))
        path.moveToPoint(CGPoint(x: self.center.x / 7 * 6, y: self.frame.size.height))
        path.addQuadCurveToPoint(CGPoint(x: self.center.x / 7 * 6.8, y: self.center.y), controlPoint: CGPoint(x: self.center.x / 7 * 6.5, y: self.frame.size.height / 10 * 9))
        path.moveToPoint(CGPoint(x: self.center.x / 7 * 8, y: 0))
        path.addQuadCurveToPoint(CGPoint(x: self.center.x / 7 * 7.2, y: self.center.y), controlPoint: CGPoint(x: self.center.x / 7 * 7.5, y: self.frame.size.height / 10))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor(red: 80/255, green: 60/255, blue: 102/255, alpha: 1).CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 1
        self.layer.addSublayer(shapeLayer)
    }
    
    private func setSubViews() {
        self.firstSkill = UILabel()
        self.secondSkill = UILabel()
    }
    
    func setSkills(firstSkill: String = "", secondSkill: String = "") {
        self.firstSkillName = firstSkill
        self.secondSkillName = secondSkill
    }
}
