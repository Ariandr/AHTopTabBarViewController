//
//  AHTopTabBarViewDelegate.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/24/18.
//

import Foundation

internal protocol AHTopTabBarViewDelegate: class {
    func didSelectItem(at indexPath: IndexPath)
}
