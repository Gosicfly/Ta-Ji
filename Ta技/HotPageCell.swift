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
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 0
        }
        scope { () -> Void in
            self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
            self.collectionView.registerClass(SquareCell.self, forCellWithReuseIdentifier: "SquareCell")
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
        print("1")
        return 13
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(String(SquareCell), forIndexPath: indexPath)
        return cell
    }
}




