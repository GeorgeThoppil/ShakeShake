//
//  ResultsPageViewController.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-03.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class ResultsPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var vcArr : [UIViewController] = {
       return [self.getViewController(name: "Results"),
               self.getViewController(name: "TopTenHighScores"),
               self.getViewController(name: "TopTenTotalScores")]
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        
        //set first view controller on load
        if let firstVC = vcArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    func getViewController(name : String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcArr.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return vcArr.last
        }
        
        guard vcArr.count > previousIndex else {
            return nil
        }
        
        return vcArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < vcArr.count else {
            return vcArr.first
        }
        
        guard vcArr.count > nextIndex else {
            return nil
        }
        
        return vcArr[nextIndex]
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArr.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = vcArr.index(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }


}
