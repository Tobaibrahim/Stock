//
//  UIHelper.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

struct UIHelper {
    
    
    static func createTwoColomnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout{
        let width                        = view.bounds.width
        let padding:CGFloat              = 10
        let minimumItemSpacing:CGFloat   = 10
        let availablewidth               = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                    = availablewidth / 2
        
        let flowLayout                   = UICollectionViewFlowLayout()
        flowLayout.sectionInset          = UIEdgeInsets(top: 50, left: padding, bottom: 100, right:
            padding)
        flowLayout.itemSize              = CGSize(width: itemWidth, height: 260 )
        
        return flowLayout
    }
    
    
}
