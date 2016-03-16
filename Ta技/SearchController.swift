//
//  SearchController.swift
//  Ta技
//
//  Created by Gosicfly on 16/2/20.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

class SearchController: UIViewController, TANavigationBarType {

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
    
    private var _itemStringArray: [String] = ["找人", "找圈子", "找标签"]
    
    private var _bottomView: UIView! {
        didSet {
            self._bottomView.backgroundColor = UIColor(red: 68/255, green: 56/255, blue: 83/255, alpha: 1)
            self._menuView.addSubview(self._bottomView)
        }
    }
    
    private var _menuViewLayout: UICollectionViewFlowLayout! {
        didSet {
            _menuViewLayout.minimumInteritemSpacing = 0
            _menuViewLayout.minimumLineSpacing = 0
            _menuViewLayout.scrollDirection = .Horizontal
            _menuViewLayout.itemSize = CGSize(width: SCREEN_WIDTH / 3, height: 27 * 1.5)
        }
    }
    
    private var _menuView: UICollectionView! {
        didSet {
            self.view.addSubview(self._menuView)
            self._menuView.registerClass(TAMenuItem.self, forCellWithReuseIdentifier: String(TAMenuItem))
            self._menuView.delegate = self
            self._menuView.dataSource = self
            self._menuView.scrollEnabled = true
            self._menuView.showsHorizontalScrollIndicator = false
            self._menuView.bounces = false
            self._menuView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 2, height: 0)
            self._menuView.backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 242/255, alpha: 1)
            self._menuView.selectItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Left)
            //底部增加分割线
            let separatorLine = UIView(frame: CGRect(x: 0, y: _menuView.bounds.height - 1, width: SCREEN_WIDTH, height: 1))
            separatorLine.backgroundColor = UIColor.lightGrayColor()
            _menuView.addSubview(separatorLine)
        }
    }
    
    private var _pageViewLayout: UICollectionViewFlowLayout! {
        didSet {
            _pageViewLayout.minimumInteritemSpacing = 0
            _pageViewLayout.minimumLineSpacing = 0
            _pageViewLayout.scrollDirection = .Horizontal;
            _pageViewLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGTH - self._menuView.bounds.height-(self.navigationController?.navigationBar.bounds.height)!-UIApplication.sharedApplication().statusBarFrame.height)
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
            self._pageView.registerNib(UINib(nibName: "SearchPageItem", bundle: nil), forCellWithReuseIdentifier: String(SearchPageItem))
            self.view.addSubview(self._pageView)
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setSubViews()
    }

    func setNavigationBar() {
        self.title = "搜索"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_register_second_back"), style: .Plain, target: self, action: Selector("back"))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
    }
    
    // MARK: - private methods
    private func setSubViews() {
        self._menuViewLayout = UICollectionViewFlowLayout()
        self._menuView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: _menuViewLayout.itemSize.height), collectionViewLayout: _menuViewLayout)
        
        self._bottomView = UIView(frame: CGRect(x: 0, y: self._menuView.bounds.height - 3, width: _menuViewLayout.itemSize.width, height: 3))
        
        self._pageViewLayout = UICollectionViewFlowLayout()
        self._pageView = UICollectionView(frame: CGRect(x: 0, y: self._menuView.bounds.height, width: SCREEN_WIDTH, height: _pageViewLayout.itemSize.height), collectionViewLayout: _pageViewLayout)
    }
    
    @objc private func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._itemStringArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self._menuView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TAMenuItem), forIndexPath: indexPath) as! TAMenuItem
            cell.name = self._itemStringArray[indexPath.row]
            cell.titleLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
            cell.titleLabel.highlightedTextColor = UIColor(red: 68/255, green: 56/255, blue: 83/255, alpha: 1)
            cell.name = self._itemStringArray[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SearchPageItem), forIndexPath: indexPath) as! SearchPageItem
            switch indexPath.row {
            case 0:
                cell.type = .People
            case 1:
                cell.type = .Circle
            case 2:
                cell.type = .Label
            default:
                break
            }
            cell.menuView = self._menuView
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self._menuView) {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TAMenuItem {
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

// MARK: - UIScrollViewDelegate
extension SearchController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self._pageView {
            scrollView.endEditing(true)
            self._bottomView.frame.origin.x = scrollView.contentOffset.x / SCREEN_WIDTH * self._bottomView.bounds.width
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
