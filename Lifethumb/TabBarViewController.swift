//
//  TabBarViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 13/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var dataManager: DataManager!
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else { return }
        
        delegate = self
        
        let navigationViewController = viewControllers.first as! UINavigationController
        let viewController = navigationViewController.visibleViewController as! CategoryTableViewController
        viewController.dataManager = dataManager
    }
    
}

// MARK - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationViewController = viewController as? UINavigationController else {
            fatalError()
        }
        
        if let tableViewController = navigationViewController.visibleViewController as? FoodTableViewController {
            tableViewController.dataManager = dataManager
        }
        
        if let tableViewController = navigationViewController.visibleViewController as? ExerciseTableViewController {
            tableViewController.dataManager = dataManager
        }
    }
    
}
