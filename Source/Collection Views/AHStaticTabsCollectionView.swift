//
//  AHStaticTabsCollectionView.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/24/18.
//

import UIKit

open class AHStaticTabsCollectionView: UICollectionView {
    
    public init(backgroundColor: UIColor = .white) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        self.isScrollEnabled = false
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
