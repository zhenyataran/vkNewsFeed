//
//  TabBarController.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let news = UINavigationController(rootViewController: NewsFeedViewController())
        news.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks, tag: 0)
        
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem.init(tabBarSystemItem: .more, tag: 1)
        
        self.viewControllers = [news, profile]
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
