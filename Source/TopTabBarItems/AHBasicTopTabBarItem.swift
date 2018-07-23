//
//  AHBasicTopTabBarItem.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHBasicTopTabBarItem<Item>: UICollectionViewCell, AHTopBarItem {
    public typealias ItemType = Item
    
    public func update(for item: Item, indexPath: IndexPath, allElementsCount: Int) {
        
    }
    
    public func setSelected(indexPath: IndexPath) {
        
    }
    
    public func setDeselected(indexPathOfSelected: IndexPath) {
        
    }
}
