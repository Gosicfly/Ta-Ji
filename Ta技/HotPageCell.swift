//
//  HotPageCell.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/6.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class HotPageCell: UICollectionViewCell {
    
    func scope(closure: () -> Void) {
        closure()
    }
    
    var collectionView: UICollectionView!
    
    var layout: UICollectionViewFlowLayout!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scope {
            self.layout = UICollectionViewFlowLayout()
            self.layout.scrollDirection = .Vertical
            self.layout.itemSize = CGSize(width: SCREEN_WIDTH / 2, height: SCREEN_HEIGTH / 3)
            self.layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 110)
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 0
        }
        scope { () -> Void in
            self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
            self.collectionView.registerClass(SquareCell.self, forCellWithReuseIdentifier: String(SquareCell))
            self.collectionView.registerClass(GFCycleScrollView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(GFCycleScrollView))
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
        self.contentView.addSubview(self.collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.collectionView.bounds = self.contentView.bounds
        self.collectionView.center = self.contentView.center
    }
    
}

extension HotPageCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(String(SquareCell), forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: String(GFCycleScrollView), forIndexPath: indexPath) as! GFCycleScrollView
        view.imageArray = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!]
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }
}




