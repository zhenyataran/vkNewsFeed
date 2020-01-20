//
//  AppDelegate.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/20/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    var authService: AuthService!
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.authService = AuthService()
        authService.delegate = self
        let vc = AuthViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
    }


}

extension AppDelegate: AuthDelegate {
    func authShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authSignIn() {
        let vc = TabBarController()
        window?.rootViewController = vc
    }
    
    func authFailedSigIn() {
        
    }
    
    
}

