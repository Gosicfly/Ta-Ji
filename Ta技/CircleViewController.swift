//
//  CommunityViewController.swift
//  TA技
//
//  Created by Gosicfly on 16/1/23.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    
    private var _menuViewItemIndex = 0 {
        willSet {
            if (self._menuViewItemIndex - newValue) < 0 {
                self._toRight = true
            } else {
                self._toRight = false
            }
        }
    }
    
    private var _toRight: Bool = true
    
    private var _itemStringArray: [String] = ["热门圈子", "我的圈子"]
    
    lazy private var _bottomView: UIView = {
        let _view = UIView()
        _view.backgroundColor = UIColor(red: 68/255, green: 56/255, blue: 83/255, alpha: 1)
        return _view
    }()
    
    private var _menuViewLayout: UICollectionViewFlowLayout! {
        didSet {
            _menuViewLayout.minimumInteritemSpacing = 0
            _menuViewLayout.minimumLineSpacing = 0
            _menuViewLayout.scrollDirection = .Horizontal
            _menuViewLayout.itemSize = CGSize(width: SCREEN_WIDTH / 2, height: 27 * 1.5)
        }
    }
    
    private var _menuView: UICollectionView! {
        didSet {
            self.view.addSubview(_menuView)
            _menuView.registerClass(TAMenuItem.self, forCellWithReuseIdentifier: String(TAMenuItem))
            _menuView.delegate = self
            _menuView.dataSource = self
            _menuView.scrollEnabled = true
            _menuView.showsHorizontalScrollIndicator = false
            _menuView.bounces = false
            _menuView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 2, height: 0)
            _menuView.backgroundColor = UIColor(red: 225/255, green: 222/255, blue: 230/255, alpha: 1)
            _menuView.selectItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Left)
            let separatorLine = UIView(frame: CGRect(x: 0, y: _menuView.bounds.height - 1, width: SCREEN_WIDTH, height: 1))
            separatorLine.backgroundColor = UIColor.lightGrayColor()
            _menuView.addSubview(separatorLine)
            _menuView.addSubview(self._bottomView)
        }
    }

    private var _pageViewLayout: UICollectionViewFlowLayout! {
        didSet {
            _pageViewLayout.minimumInteritemSpacing = 0
            _pageViewLayout.minimumLineSpacing = 0
            _pageViewLayout.scrollDirection = .Horizontal;
            _pageViewLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGTH - self._menuView.bounds.height-(self.navigationController?.navigationBar.bounds.height)!-UIApplication.sharedApplication().statusBarFrame.height-(self.tabBarController?.tabBar.bounds.height)!)
        }
    }
    
    private var _pageView: UICollectionView! {
        didSet {
            self._pageView.dataSource = self
            self._pageView.delegate = self
            self._pageView.scrollEnabled = true
            self._pageView.pagingEnabled = true
            self._pageView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: SCREEN_HEIGTH - self._menuView.bounds.height)
            self._pageView.bounces = false
            self._pageView.showsHorizontalScrollIndicator = false
            self._pageView.registerClass(RecommendPageItem.self, forCellWithReuseIdentifier: String(RecommendPageItem))
            self.view.addSubview(self._pageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubviews()
    }
    
    //TO Fix...
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let currentCell = self._menuView.cellForItemAtIndexPath(NSIndexPath(forItem: self._menuViewItemIndex, inSection: 0)) as! TAMenuItem
        let size = currentCell.titleLabel.text!.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14)])
        self._bottomView.frame = CGRect(x: 0, y: self._menuView.bounds.height - 3, width: size.width, height: 3)
        self._bottomView.center.x = currentCell.titleLabel.center.x + _menuViewLayout.itemSize.width * CGFloat(_menuViewItemIndex)
    }
    
    private func setSubviews() {
        self._menuViewLayout = UICollectionViewFlowLayout()
        self._menuView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: _menuViewLayout.itemSize.height), collectionViewLayout: _menuViewLayout)
        
//        self._bottomView = UIView(frame: CGRect(x: 0, y: self._menuView.bounds.height - 3, width: _menuViewLayout.itemSize.width, height: 3))
        
        self._pageViewLayout = UICollectionViewFlowLayout()
        self._pageView = UICollectionView(frame: CGRect(x: 0, y: self._menuView.bounds.height, width: SCREEN_WIDTH, height: _pageViewLayout.itemSize.height), collectionViewLayout: _pageViewLayout)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension CircleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._itemStringArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self._menuView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TAMenuItem), forIndexPath: indexPath) as! TAMenuItem
            cell.name = self._itemStringArray[indexPath.row]
            self._bottomView.center = cell.center
            cell.titleLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
            cell.titleLabel.highlightedTextColor = UIColor(red: 68/255, green: 56/255, blue: 83/255, alpha: 1)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(RecommendPageItem), forIndexPath: indexPath) as! RecommendPageItem
            switch indexPath.row {
            case 0:
                cell.type = .Hot
            case 1:
                cell.type = .Mine
            default:
                break
            }
            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self._menuView) {
            if let _ = collectionView.cellForItemAtIndexPath(indexPath) as? TAMenuItem {
                self._menuView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
                self._pageView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            } else {
                if self._toRight {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row - 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row - 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        }, completion: { (_) -> Void in
                            UIView.animateWithDuration(0.1, animations: { () -> Void in
                                self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                                self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                            })
                    })
                } else {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        }, completion: { (_) -> Void in
                            UIView.animateWithDuration(0.1, animations: { () -> Void in
                                self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                                self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                            })
                    })
                }
            }
            self._menuView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        }
    }
}

//MARK: -UIScrollViewDelegate
extension CircleViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self._pageView {
            self._bottomView.center.x = scrollView.contentOffset.x / 2 + _menuViewLayout.itemSize.width / 2
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView == self._pageView) {
            self._menuViewItemIndex = Int(scrollView.contentOffset.x / self._pageView.frame.size.width)
            let indexPath = NSIndexPath(forItem: self._menuViewItemIndex, inSection: 0)
            self.collectionView(self._menuView, didSelectItemAtIndexPath: indexPath)
        }
    }
}


