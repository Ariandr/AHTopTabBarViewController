//
//  AHContentPageViewControllerDelegate.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import Foundation

internal protocol AHContentPageViewControllerDelegate: class {
    func didSelectPage(at index: Int)
    func didScroll(_ direction: ScrollDirection, percent: CGFloat)
}
