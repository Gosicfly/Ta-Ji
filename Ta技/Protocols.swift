//
//  Protocols.swift
//  Ta技
//
//  Created by Gosicfly on 16/1/26.
//  Copyright © 2016年 Gosicfly. All rights reserved.
//

import UIKit

protocol ItemSelectable: class {
    
    var selectedItem: UIView! { get set }
}

protocol HomeTitleViewDelegate: class {
    
    func transition(fromeViewController fromeViewController: UIViewController, toViewController: UIViewController, completion: ((Bool) -> Void)?)
}

protocol TANavigationBarType: class {
    
    func setNavigationBar()
}