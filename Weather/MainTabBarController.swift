//
//  MainTabBarController.swift
//  Weather
//
//  Created by Alen Kirm on 7. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainController = MainController()
        mainController.tabBarItem.image = UIImage(named: "menu_icon")
        mainController.title = "RED"
        
        let mainController2 = Main2Controller()
        
        let navController = UINavigationController(rootViewController: mainController2)
        navController.tabBarItem.image = UIImage(named: "menu_icon")
        navController.title = "BLUE"
        
        viewControllers = [mainController, navController]
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.darkGray.cgColor
        
        tabBar.layer.addSublayer(topBorder)
    }
    
}
