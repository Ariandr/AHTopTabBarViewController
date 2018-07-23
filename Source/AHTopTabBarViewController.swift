//
//  AHTopTabBarViewController.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHTopTabBarViewController: UIViewController {
    
    // MARK: - Properties
    
    open var tabBarView: AHTopTabBarView
    
    open var contentViewController: AHContentPageViewController
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    
    public init(contentViewController: AHContentPageViewController, topTabBarView: AHTopTabBarView) {
        self.contentViewController = contentViewController
        self.tabBarView = topTabBarView
        
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupContentController()
        setupApperance()
        
        contentViewController.scrollDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance
    
    open func setupApperance() {
        view.backgroundColor = .white
    }
    
    // MARK: - Views Setup
    
    open func setupViews() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tabBarView)
        if #available(iOS 11.0, *) {
            tabBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            tabBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: tabBarView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    open func setupContentController() {
        addChildViewController(contentViewController)
        contentView.addSubview(contentViewController.view)
        contentViewController.didMove(toParentViewController: self)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

extension AHTopTabBarViewController: AHContentPageViewControllerDelegate {
    func didSelectPage(at index: Int) {
        print(index)
    }
    
    func didScroll(_ direction: ScrollDirection, percent: CGFloat) {
        print(percent)
    }
}
