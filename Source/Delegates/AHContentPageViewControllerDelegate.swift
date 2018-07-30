//
//  AHContentPageViewControllerDelegate.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import Foundation

public protocol AHContentPageViewControllerDelegate: class {
    func didSelectPage(at index: Int)
    func didScroll(_ direction: ScrollDirection, percent: CGFloat)
}
