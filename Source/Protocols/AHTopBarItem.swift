//
//  AHTopTabBarItem.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import Foundation

public protocol AHTopBarItem: class {
    func update(with content: AHItemContent, at indexPath: IndexPath, itemsCount: Int)
    func setSelected(at indexPath: IndexPath)
    func setDeselected(at indexPath: IndexPath)
}
