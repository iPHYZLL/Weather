//
//  AppDelegate.swift
//  Weather
//
//  Created by Alen Kirm on 7. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // API Key for GooglePlaces
        GMSPlacesClient.provideAPIKey(PLACES_API_KEY)
        
        window = UIWindow()
        
        let mainController = MainController()
        let mainNavigationController = UINavigationController(rootViewController: mainController)
        mainNavigationController.view.backgroundColor = UIColor.themedWhite
        
        let backImage = UIImage(named: "back")
        mainNavigationController.navigationBar.backIndicatorImage = backImage
        mainNavigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        // no translucency for navigation bar
        UINavigationBar.appearance().isTranslucent = false
        
        // navigation bar background color
        UINavigationBar.appearance().barTintColor = UIColor.themedWhite
        
        // navigation bar controls color
        UINavigationBar.appearance().tintColor = UIColor.themedBlue
        
        // navigation bar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.themedBlue]
        
        // TOGGLE, ITS OPTIONAL
        // navigation bar large title
//        mainNavigationController.navigationBar.prefersLargeTitles = true
//        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.themedWhite]
        
        // status bar style
//        application.statusBarStyle = .lightContent
        
        // remove navigation bar bottom shadow
        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

