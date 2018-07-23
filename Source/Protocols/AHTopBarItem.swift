//
//  AHTopTabBarItem.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import Foundation

public protocol AHTopBarItem: class {
    associatedtype ItemType
    func update(for item: ItemType, indexPath: IndexPath, allElementsCount: Int)
    func setSelected(indexPath: IndexPath)
    func setDeselected(indexPathOfSelected: IndexPath)
}
