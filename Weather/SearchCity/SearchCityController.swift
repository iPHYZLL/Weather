//
//  SearchCityController.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class SearchCityController: UIViewController {
    
    let searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundImage = UIImage()
        return sb
    }()
    
    let padding : CGFloat = 20
    
    fileprivate func customizeSearchBar() {
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "City", attributes: [NSAttributedStringKey.foregroundColor : UIColor.themedBlue, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.themedBlue, NSAttributedStringKey.font.rawValue : UIFont.boldSystemFont(ofSize: 14)]
        
        UISearchBar.appearance().tintColor  = UIColor.themedBlue
        UISearchBar.appearance().barTintColor = UIColor.themedWhite
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.themedWhite
        
        view.addSubview(searchBar)
        searchBar.anchor(top: view.topAnchor, paddingTop: 100, right: view.rightAnchor, paddingRight: padding, left: view.leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 75)
        
        customizeSearchBar()
    }
    
}
