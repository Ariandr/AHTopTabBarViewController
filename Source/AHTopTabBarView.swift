//
//  AHTopTabBarView.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHTopTabBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private let cellClass: AHTopBarItem.Type
    private var objects: [AHItemContent]
    private (set) var selectedItemIndex = 0
    
    private var itemsPerRow: CGFloat {
        return CGFloat(objects.count)
    }
    
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private lazy var tabsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initializers
    
    public init(itemClass: AHTopBarItem.Type, objects: [AHItemContent]) {
        self.cellClass = itemClass
        self.objects = objects
        
        super.init(frame: .zero)
        
        tabsCollectionView.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Available Methods
    
    public func set(objects: [AHItemContent]) {
        self.objects = objects
        tabsCollectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath)
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
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        let availableWidth = collectionView.bounds.width - paddingSpace
        
        let widthPerItem = (availableWidth / itemsPerRow).rounded(.up)
        
        return CGSize(width: widthPerItem, height: collectionView.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.top
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(for: indexPath)
    }
    
    private func selectItem(for indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        tabsCollectionView.reloadData()
    }
    
    func selectItem(index: Int) {
        selectItem(for: IndexPath(row: index, section: 0))
    }
    
    private func setupViews() {
        addSubview(tabsCollectionView)
        tabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabsCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
