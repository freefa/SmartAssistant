//
//  AppDelegate.swift
//  SmartAssistant
//
//  Created by 路标 on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let home = HomeViewController()
        let rootNav = SABaseNavigationController(rootViewController: home)
        self.window?.rootViewController = rootNav
        self.window?.makeKeyAndVisible()
        return true
    }

}

