//
//  AHTopTabBarViewController.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHTopTabBarViewController: UIViewController {
    
    // MARK: - Properties
    
    open var topTabBarView: AHTopTabBarView
    
    open var contentViewController: AHContentPageViewController
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    
    public init(contentViewController: AHContentPageViewController, topTabBarView: AHTopTabBarView) {
        self.contentViewController = contentViewController
        self.topTabBarView = topTabBarView
        
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupContentController()
        setupApperance()
        
        contentViewController.scrollDelegate = self
        topTabBarView.delegate = self
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
        topTabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topTabBarView)
        setupTopTabBarConstraints()
        
        view.addSubview(contentView)
        setupContentViewConstraints()
    }
    
    open func setupTopTabBarConstraints() {
        if #available(iOS 11.0, *) {
            topTabBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            topTabBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            topTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topTabBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    open func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topTabBarView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        if #available(iOS 11.0, *) {
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            contentView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        }
    }
    
    open func setupContentController() {
        addChildViewController(contentViewController)
        contentView.addSubview(contentViewController.view)
        contentViewController.didMove(toParentViewController: self)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        setupContentControllerConstraints()
    }
    
    open func setupContentControllerConstraints() {
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
        topTabBarView.selectItem(at: index)
    }
    
    func didScroll(_ direction: ScrollDirection, percent: CGFloat) {
        // TODO
    }
}

extension AHTopTabBarViewController: AHTopTabBarViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        contentViewController.openPage(at: indexPath.item)
    }
}
