//
//  AHTextTopBarItem.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

extension String: AHItemContent {
    
}

public struct AHTextTopBarItemAppearance: AHTopBarItemAppearance {
    public var selectedBackgroundColor = UIColor.white
    public var deselectedBackgroundColor = UIColor.red
    public var selectedVerticalLineColor = UIColor.white
    public var deselectedVerticalLineColor = UIColor.clear
    public var selectedTextColor = UIColor.black
    public var deselectedTextColor = UIColor.white
    public var textSideMargin = CGFloat(8)
    public var selectionLineColor = UIColor.black
    public var selectionLineHeight = CGFloat(3)
    public var selectionLineWidthMultiplier = CGFloat(0.92)
    public var selectionLineCornerRadious = CGFloat(0)
    public var verticalLineWidth = CGFloat(0.5)
    public var verticalLineHeightMultiplier = CGFloat(0.7)
    public var numberOfTextLines = 1
    public var adjustsFontSizeToFitWidth = true
    public var textAlignment = NSTextAlignment.center
    public var textFont = UIFont.systemFont(ofSize: 16)
}

open class AHTextTopBarItem: AHBasicTopTabBarItem {
    
    open static var appearance = AHTextTopBarItemAppearance()
    
    private var currentIndexPath = IndexPath(row: 0, section: 0)
    
    open lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AHTextTopBarItem.appearance.textFont
        label.textColor = AHTextTopBarItem.appearance.deselectedTextColor
        label.numberOfLines = AHTextTopBarItem.appearance.numberOfTextLines
        label.textAlignment = AHTextTopBarItem.appearance.textAlignment
        label.adjustsFontSizeToFitWidth = AHTextTopBarItem.appearance.adjustsFontSizeToFitWidth
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open let leftVerticalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open let rightVerticalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open lazy var selectionLine: UIView = {
        let view = UIView()
        view.backgroundColor = AHTextTopBarItem.appearance.selectionLineColor
        view.layer.cornerRadius = AHTextTopBarItem.appearance.selectionLineCornerRadious
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = AHTextTopBarItem.appearance.deselectedBackgroundColor
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: AHTextTopBarItem.appearance.textSideMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -AHTextTopBarItem.appearance.textSideMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(leftVerticalLine)
        leftVerticalLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        leftVerticalLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftVerticalLine.widthAnchor.constraint(equalToConstant: AHTextTopBarItem.appearance.verticalLineWidth).isActive = true
        leftVerticalLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AHTextTopBarItem.appearance.verticalLineHeightMultiplier).isActive = true
        
        addSubview(rightVerticalLine)
        rightVerticalLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightVerticalLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightVerticalLine.widthAnchor.constraint(equalToConstant: AHTextTopBarItem.appearance.verticalLineWidth).isActive = true
        rightVerticalLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AHTextTopBarItem.appearance.verticalLineHeightMultiplier).isActive = true
        
        addSubview(selectionLine)
        selectionLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectionLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectionLine.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AHTextTopBarItem.appearance.selectionLineWidthMultiplier).isActive = true
        selectionLine.heightAnchor.constraint(equalToConstant: AHTextTopBarItem.appearance.selectionLineHeight).isActive = true
    }
    
    override public func update(with content: AHItemContent, at indexPath: IndexPath, itemsCount: Int) {
        guard let string = content as? String else {
            return
        }
        currentIndexPath = indexPath
        titleLabel.text = string
        
        if indexPath.row == 0 {
            leftVerticalLine.isHidden = true
        } else {
            leftVerticalLine.isHidden = false
        }
        
        if indexPath.row == itemsCount - 1 {
            rightVerticalLine.isHidden = true
        } else {
            rightVerticalLine.isHidden = false
        }
    }
    
    override public func setSelected(at indexPath: IndexPath) {
        titleLabel.textColor = AHTextTopBarItem.appearance.selectedTextColor
        selectionLine.isHidden = false
        backgroundColor = AHTextTopBarItem.appearance.selectedBackgroundColor
        leftVerticalLine.backgroundColor = AHTextTopBarItem.appearance.deselectedVerticalLineColor
        rightVerticalLine.backgroundColor = AHTextTopBarItem.appearance.deselectedVerticalLineColor
    }
    
    override public func setDeselected(at indexPathOfSelected: IndexPath) {
        if currentIndexPath.row - indexPathOfSelected.row == -1 {
            leftVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
            rightVerticalLine.backgroundColor = AHTextTopBarItem.appearance.deselectedVerticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row < -1 {
            leftVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
            rightVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row == 1 {
            leftVerticalLine.backgroundColor = AHTextTopBarItem.appearance.deselectedVerticalLineColor
            rightVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row > 1 {
            leftVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
            rightVerticalLine.backgroundColor = AHTextTopBarItem.appearance.selectedVerticalLineColor
        }
        titleLabel.textColor = AHTextTopBarItem.appearance.deselectedTextColor
        selectionLine.isHidden = true
        backgroundColor = AHTextTopBarItem.appearance.deselectedBackgroundColor
    }
}
