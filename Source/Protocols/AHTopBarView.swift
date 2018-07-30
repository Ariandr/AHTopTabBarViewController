//
//  AHTopBarView.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/30/18.
//

import Foundation

public protocol AHTopBarView: class {
    var delegate: AHTopBarViewDelegate? { get set }
    func selectItem(at indexPath: IndexPath)
    func set(objects: [AHItemContent])
}
