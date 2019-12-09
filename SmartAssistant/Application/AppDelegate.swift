//
//  AppDelegate.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit
@_exported import Log
@_exported import TencentAiBase
@_exported import TencentAiOCR
@_exported import TencentAiTranslate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Log("application didFinishLaunching sandbox:\n\(NSHomeDirectory())")
        TencentAiConfig.register(appId: TENCENT_AI_APP_ID, appKey: TENCENT_AI_APP_KEY)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let home = HomeViewController()
        let rootNav = SABaseNavigationController(rootViewController: home)
        self.window?.rootViewController = rootNav
        self.window?.makeKeyAndVisible()
        return true
    }

}

