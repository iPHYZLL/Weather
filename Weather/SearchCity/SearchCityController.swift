//
//  SearchCityController.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import GooglePlaces

protocol SearchCityDelegate {
    
    func didSent(cityName : String)
    
}

class SearchCityController: UIViewController {
    
    var delegate : SearchCityDelegate?
    
    let cities = ["Trebnje", "Novo mesto", "Ljubljana", "Maribor", "Celje", "Zagreb", "Kupinec", "Klinča Sela", "Mirna"]
    
    var citiesNew = [NSAttributedString]()
    
    let searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundImage = UIImage()
        sb.backgroundColor = UIColor.themedGray
        sb.layer.cornerRadius = 10
        sb.showsCancelButton = true
        return sb
    }()
    
    var infoLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        
        let text = NSMutableAttributedString(string: "Type in the name of a city\nto see it's forecast.", attributes: [NSAttributedStringKey.foregroundColor : UIColor.themedBlack, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)])
        
        l.attributedText = text
        
        return l
    }()
    
    let tableView : UITableView = {
        let tv = UITableView()
        tv.layer.cornerRadius = 10
        tv.backgroundColor = UIColor.themedWhite
        tv.separatorStyle = .none
        return tv
    }()
    
    let padding : CGFloat = 20
    
    fileprivate func setupTableView() {
        tableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    fileprivate func customizeSearchBar() {
        
        // this approach rocks !!!!
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = UIColor.themedGray
            searchTextField.textColor = UIColor.themedBlue
            searchTextField.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search by city", attributes: [NSAttributedStringKey.foregroundColor : UIColor.themedBlue, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
        
        UISearchBar.appearance().tintColor  = UIColor.themedBlue

    }
    
    // google places
    
    func placeAutocomplete(text : String) {
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        
        let placesClient = GMSPlacesClient()
        
        citiesNew.removeAll()
        tableView.reloadData()
        
        placesClient.autocompleteQuery(text, bounds: nil, filter: filter) { (results, err) in
            
            if let err = err {
                print("Autocomplete error \(err)")
                return
            }
            
            guard let results = results else { return }
            
            for result in results {
                self.citiesNew.append(result.attributedFullText)
                print(result.attributedFullText)
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.themedWhite
        
        view.addSubview(infoLabel)
        infoLabel.anchor(top: view.topAnchor, paddingTop: 40, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
        view.addSubview(searchBar)
        searchBar.anchor(top: infoLabel.bottomAnchor, paddingTop: 40, right: view.rightAnchor, paddingRight: padding, left: view.leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 40)
        
        customizeSearchBar()
        searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor, paddingTop: padding, right: view.rightAnchor, paddingRight: padding, left: view.leftAnchor, paddingLeft: padding, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: padding, width: 0, height: 0)
        
        // register cell to reuse, and set delegate and datasource for table view
        setupTableView()
        
    }
    
}

////////////////////////////////////////////////////////
// MARK: TableView stuff
////////////////////////////////////////////////////////

extension SearchCityController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return citiesNew.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell else { return UITableViewCell() }
        
        let city = citiesNew[indexPath.section]
        
        cell.cityName.attributedText = city
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let tappedCell = tableView.cellForRow(at: indexPath) as? CityCell else { return }
        
        guard let cityName = tappedCell.cityName.text else { return }
        
        guard let trimIndex = cityName.index(of: ",")?.encodedOffset else { return }
        
        // trim and create new substring .... characters from 0 too index when "," occurs.
        let newCityName = cityName.prefix(trimIndex)
        
        guard let delegate = delegate else { return }
        
        delegate.didSent(cityName: String(newCityName))

        
        navigationController?.popViewController(animated: true)
    }
    
}

////////////////////////////////////////////////////////
// MARK: SearchBar stuff
////////////////////////////////////////////////////////

extension SearchCityController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("searchBarSearchButtonClicked")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        citiesNew.removeAll()
        tableView.reloadData()
        print("search button clicked")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        placeAutocomplete(text: text)
        print("searchBarTextDidEndEditing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.endEditing(true)
            citiesNew = []
            tableView.reloadData()
        } else {
            placeAutocomplete(text: searchText)
        }
    }
    
    
}


















