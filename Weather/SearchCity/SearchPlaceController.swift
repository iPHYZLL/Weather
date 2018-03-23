//
//  SearchPlaceController.swift
//  Weather
//
//  Created by Alen Kirm on 23. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchPlaceController : UIViewController, UISearchControllerDelegate {
    
    
    var searchBar : UISearchBar?
    var tableDataSource : GMSAutocompleteTableDataSource?
    var searchController : UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 250.0, height: 44.0))
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource?.delegate = self
        
        searchController = UISearchController(searchResultsController: self)
        searchController?.delegate = self

        
    }
    
    
}

extension SearchPlaceController : GMSAutocompleteTableDataSourceDelegate {
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        
    }
    
    
}
