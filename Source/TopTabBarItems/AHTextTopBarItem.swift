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
    var selectedBackgroundColor = UIColor.white
    var deselectedBackgroundColor = UIColor.red
    var verticalLineColor = UIColor.white
    var selectedTextColor = UIColor.black
    var deselectedTextColor = UIColor.white
    var selectionLineColor = UIColor.black
    var selectionLineHeight = CGFloat(3)
    var selectionLineWidthMultiplier = CGFloat(0.92)
    var selectionLineCornerRadious = CGFloat(0)
}

open class AHTextTopBarItem: AHBasicTopTabBarItem {
    
    open var appearance = AHTextTopBarItemAppearance()
    
    private var currentIndexPath = IndexPath(row: 0, section: 0)
    
    open lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.deselectedTextColor
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    open let leftVerticalLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open let rightVerticalLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open lazy var selectionLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = appearance.selectionLineColor
        view.layer.cornerRadius = appearance.selectionLineCornerRadious
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
        backgroundColor = appearance.deselectedBackgroundColor
        
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
        
        addSubview(selectionLine)
        selectionLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectionLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectionLine.widthAnchor.constraint(equalTo: widthAnchor, multiplier: appearance.selectionLineWidthMultiplier).isActive = true
        selectionLine.heightAnchor.constraint(equalToConstant: appearance.selectionLineHeight).isActive = true
    }
    
    override public func update(with content: AHItemContent, at indexPath: IndexPath, itemsCount: Int) {
        guard let string = content as? String else {
            return
        }
        currentIndexPath = indexPath
        titleLabel.text = string.uppercased()
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
        titleLabel.textColor = appearance.selectedTextColor
        selectionLine.isHidden = false
        backgroundColor = appearance.selectedBackgroundColor
        leftVerticalLine.backgroundColor = .clear
        rightVerticalLine.backgroundColor = .clear
    }
    
    override public func setDeselected(at indexPathOfSelected: IndexPath) {
        if currentIndexPath.row - indexPathOfSelected.row == -1 {
            leftVerticalLine.backgroundColor = appearance.verticalLineColor
            rightVerticalLine.backgroundColor = .clear
        } else if currentIndexPath.row - indexPathOfSelected.row < -1 {
            leftVerticalLine.backgroundColor = appearance.verticalLineColor
            rightVerticalLine.backgroundColor = appearance.verticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row == 1 {
            leftVerticalLine.backgroundColor = .clear
            rightVerticalLine.backgroundColor = appearance.verticalLineColor
        } else if currentIndexPath.row - indexPathOfSelected.row > 1 {
            leftVerticalLine.backgroundColor = appearance.verticalLineColor
            rightVerticalLine.backgroundColor = appearance.verticalLineColor
        }
        titleLabel.textColor = appearance.deselectedTextColor
        selectionLine.isHidden = true
        backgroundColor = appearance.deselectedBackgroundColor
    }
}
