//
//  AHTopTabBarView.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHTopTabBarView: UIView, AHTopBarView {
    
    // MARK: - Properties
    
    private let itemClass: AHTopBarItem.Type
    private var objects: [AHItemContent]
    
    private (set) var selectedItemIndex = 0
    
    private var itemsPerRow: CGFloat {
        return CGFloat(objects.count)
    }
    
    private var tabsCollectionView: UICollectionView
    
    private var underlineView: UIView?
    
    weak public var delegate: AHTopBarViewDelegate?
    
    open let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    // MARK: - Initializers
    
    public convenience init(objects: [String]) {
        self.init(itemClass: AHTextTopBarItem.self, objects: objects, tabsCollectionView: AHStaticTabsCollectionView())
    }
    
    public init(itemClass: AHTopBarItem.Type, objects: [AHItemContent], tabsCollectionView: UICollectionView, underlineView: UIView? = nil) {
        self.itemClass = itemClass
        self.objects = objects
        self.tabsCollectionView = tabsCollectionView
        self.underlineView = underlineView
        
        super.init(frame: .zero)
        
        setupViews()
        
        registerItems()
        
        setupDelegates()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial Setup
    
    open func registerItems() {
        self.tabsCollectionView.register(itemClass, forCellWithReuseIdentifier: String(describing: itemClass))
    }
    
    open func setupDelegates() {
        self.tabsCollectionView.dataSource = self
        self.tabsCollectionView.delegate = self
    }
    
    open func setupViews() {
        addSubview(tabsCollectionView)
        tabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabsCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Available Methods
    
    public func set(objects: [AHItemContent]) {
        self.objects = objects
        tabsCollectionView.reloadData()
    }
    
    open func selectItem(at indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        tabsCollectionView.reloadData()
    }
    
    open func selectItem(at index: Int) {
        selectItem(at: IndexPath(row: index, section: 0))
    }
}

extension AHTopTabBarView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: itemClass), for: indexPath)
        if let cell = cell as? AHTopBarItem {
            cell.update(with: objects[indexPath.row], at: indexPath, itemsCount: objects.count)
            if indexPath.row == selectedItemIndex {
                cell.setSelected(at: indexPath)
            } else {
                cell.setDeselected(at: IndexPath(row: selectedItemIndex, section: indexPath.section))
            }
        }
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
}

extension AHTopTabBarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(at: indexPath)
        delegate?.didSelectItem(at: indexPath)
    }
}

extension AHTopTabBarView: UICollectionViewDelegateFlowLayout {
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        let availableWidth = collectionView.bounds.width - paddingSpace
        
        let widthPerItem = (availableWidth / itemsPerRow).rounded(.up)
        
        return CGSize(width: widthPerItem, height: collectionView.bounds.height)
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.top
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
}
