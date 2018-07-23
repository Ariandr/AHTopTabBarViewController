//
//  AHTopTabBarView.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

final class DashboardTopBarCell: AHBasicTopTabBarItem<String> {
    
    private let defaultBackgroundColor = UIColor.red
    private let selectedBackgroundColor = UIColor.white
    private var currentIndexPath = IndexPath(row: 0, section: 0)
    private let verticalLineColor = UIColor.white
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftVerticalLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightVerticalLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectionLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = defaultBackgroundColor
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(leftVerticalLine)
        leftVerticalLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        leftVerticalLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftVerticalLine.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        leftVerticalLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        addSubview(rightVerticalLine)
        rightVerticalLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightVerticalLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightVerticalLine.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        rightVerticalLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        addSubview(underline)
        underline.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underline.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        underline.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(selectionLine)
        selectionLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectionLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectionLine.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        selectionLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    override func update(for item: String, indexPath: IndexPath, allElementsCount: Int) {
        currentIndexPath = indexPath
        titleLabel.text = item.uppercased()
        if indexPath.row == 0 {
            leftVerticalLine.isHidden = true
        } else {
            leftVerticalLine.isHidden = false
        }
        
        if indexPath.row == allElementsCount - 1 {
            rightVerticalLine.isHidden = true
        } else {
            rightVerticalLine.isHidden = false
        }
    }
    
    override func setSelected(indexPath: IndexPath) {
        titleLabel.textColor = .black
        selectionLine.isHidden = false
        backgroundColor = selectedBackgroundColor
        leftVerticalLine.backgroundColor = .clear
        rightVerticalLine.backgroundColor = .clear
    }
    
    override func setDeselected(indexPathOfSelected: IndexPath) {
        if currentIndexPath.row - indexPathOfSelected.row == -1 {
            leftVerticalLine.backgroundColor = verticalLineColor
            rightVerticalLine.backgroundColor = .clear
        } else if currentIndexPath.row - indexPathOfSelected.row < -1 {
            leftVerticalLine.backgroundColor = verticalLineColor
            rightVerticalLine.backgroundColor = verticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row == 1 {
            leftVerticalLine.backgroundColor = .clear
            rightVerticalLine.backgroundColor = verticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row > 1 {
            leftVerticalLine.backgroundColor = verticalLineColor
            rightVerticalLine.backgroundColor = verticalLineColor
        }
        titleLabel.textColor = .white
        selectionLine.isHidden = true
        backgroundColor = defaultBackgroundColor
    }
}

open class AHTopTabBarView<Item>: UIView, UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    //var item = AHBasicTopTabBarItem<String>()
    
    // MARK: - Properties
    
    private let cellClass: AnyClass
    private var items: [Item]
    private (set) var selectedItemIndex = 0
    
    private var itemsPerRow: CGFloat {
        return CGFloat(items.count)
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
    
    init(cellClass: AnyClass, items: [Item]) {
        self.cellClass = cellClass
        self.items = items
        
        super.init(frame: .zero)
        
        tabsCollectionView.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Available Methods
    
    public func set(items: [Item]) {
        self.items = items
        tabsCollectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath)
        if let cell = cell as? AHBasicTopTabBarItem<Item> {
            cell.update(for: items[indexPath.row], indexPath: indexPath, allElementsCount: items.count)
            if indexPath.row == selectedItemIndex {
                cell.setSelected(indexPath: indexPath)
            } else {
                cell.setDeselected(indexPathOfSelected: IndexPath(row: selectedItemIndex, section: indexPath.section))
            }
        }
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
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

//extension AHTopTabBarView: UICollectionViewDataSource {
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath)
//        if let cell = cell as? AHTopBarItem {
//            cell.update(for: items[indexPath.row], indexPath: indexPath, allElementsCount: items.count)
//            if indexPath.row == selectedItemIndex {
//                cell.setSelected(indexPath: indexPath)
//            } else {
//                cell.setDeselected(indexPathOfSelected: IndexPath(row: selectedItemIndex, section: indexPath.section))
//            }
//        }
//        return cell
//    }
//
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//}
