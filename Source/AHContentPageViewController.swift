//
//  AHContentPageViewController.swift
//  AHTopTabBarViewController
//
//  Created by Aleksandr Honcharov on 7/23/18.
//

import UIKit

open class AHContentPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var viewControllersList: [UIViewController]
    
    private var currentPageIndex = 0 {
        didSet {
            scrollDelegate?.didSelectPage(at: currentPageIndex)
        }
    }
    
    public private(set) var startOffset: CGFloat = 0.0
    
    weak var scrollDelegate: AHContentPageViewControllerDelegate?
    
    // MARK: - Initializers
    
    public init(viewControllers: [UIViewController], transitionStyle: UIPageViewControllerTransitionStyle = .scroll, navigationOrientation: UIPageViewControllerNavigationOrientation = .horizontal, options: [String: Any]? = nil) {
        
        self.viewControllersList = viewControllers
        
        super.init(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        setScrollViewDelegate()
        
        if let firstViewController = viewControllersList.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Available Methods
    
    open func openNextPage() {
        changePage(direction: .forward)
    }
    
    open func openPreviousPage() {
        changePage(direction: .reverse)
    }
    
    // MARK: - Private Methods
    
    private func setScrollViewDelegate() {
        for view in view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    private func changePage(direction: UIPageViewControllerNavigationDirection) {
        
        var pageIndex = currentPageIndex
        
        if direction == .forward {
            pageIndex += 1
        } else {
            pageIndex -= 1
        }
        
        guard pageIndex >= 0 && pageIndex < viewControllersList.count else {
            return
        }
        
        let nextController = viewControllersList[pageIndex]
        
        setViewControllers([nextController], direction: direction, animated: true) { result in
            self.currentPageIndex = pageIndex
        }
    }
}

extension AHContentPageViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllersList.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard  previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllersList.count > previousIndex else {
            return nil
        }
        
        return viewControllersList[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllersList.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        guard viewControllersList.count > nextIndex else {
            return nil
        }
        
        return viewControllersList[nextIndex]
    }
}

extension AHContentPageViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first else {
            return
        }
        
        guard let vcIndex = viewControllersList.index(of: nextVC) else {
            return
        }
        
        currentPageIndex = vcIndex
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            guard let previousVC = previousViewControllers.first else {
                return
            }
            
            guard let vcIndex = viewControllersList.index(of: previousVC) else {
                return
            }
            
            currentPageIndex = vcIndex
        }
    }
}

extension AHContentPageViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var direction = ScrollDirection.stopped
        
        if startOffset < scrollView.contentOffset.x {
            direction = .forward
        } else if startOffset > scrollView.contentOffset.x {
            direction = .back
        }
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        let percent = positionFromStartOfCurrentPage / view.bounds.width
        
        scrollDelegate?.didScroll(direction, percent: percent)
    }
}

public enum ScrollDirection {
    case forward
    case back
    case stopped
}
