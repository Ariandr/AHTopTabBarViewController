//
//  AHTextTopBarItem.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

extension String: AHItemContent {
    
}

open class AHTextTopBarItem: AHBasicTopTabBarItem {
    
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
    
    required public init?(coder aDecoder: NSCoder) {
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
        titleLabel.textColor = .black
        selectionLine.isHidden = false
        backgroundColor = selectedBackgroundColor
        leftVerticalLine.backgroundColor = .clear
        rightVerticalLine.backgroundColor = .clear
    }
    
    override public func setDeselected(at indexPathOfSelected: IndexPath) {
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
