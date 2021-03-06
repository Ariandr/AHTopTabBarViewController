//
//  AHTopBarItemAppearance.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/24/18.
//

import UIKit

public protocol AHTopBarItemAppearance {
    var selectedBackgroundColor: UIColor { get set }
    var deselectedBackgroundColor: UIColor { get set }
}
