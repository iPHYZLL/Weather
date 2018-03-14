//
//  WeeklyController.swift
//  Weather
//
//  Created by Alen Kirm on 12. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class WeeklyController: UIViewController {
    
    var weeklyWeather : [DailyWeather]!
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.themedWhite
        cv.showsVerticalScrollIndicator = false
        cv.layer.cornerRadius = 10
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.themedWhite
        
        // add collection view to view and configure it (register cell, delegate, data source etc)
        configureCollectionView()
        
    }
    
    fileprivate func configureCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // register our custom cell to reuse later on
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: "DailyWeatherCell")
        
    }
    
    var currentModalView : WVModalView?
    
    @objc func closeModal() {
        guard let modalView = currentModalView else { return }
        
        modalView.removeFromSuperview()
        self.collectionView.layoutIfNeeded()
        collectionView.isScrollEnabled = true
    }
}

////////////////////////////////////////////////////////
// MARK: COLLECTION VIEW STUFF
////////////////////////////////////////////////////////

extension WeeklyController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyWeatherCell", for: indexPath) as? DailyWeatherCell else { return UICollectionViewCell() }
        
        let weather = weeklyWeather[indexPath.item]
        
        cell.imageView.image = UIImage(named: weather.icon.getSummaryCode())
        cell.summaryLabel.text = weather.summary
        cell.highTempLabel.text = "\(weather.temperatureHigh.rounded())°"
        cell.highTempTimeLabel.text = weather.temperatureHighTime.toHour()
        cell.lowTempLabel.text = "\(weather.temperatureLow.rounded())°"
        cell.lowTempTimeLabel.text = weather.temperatureLowTime.toHour()
        cell.dayLabel.text = indexPath.item == 0 ? "TODAY" : weather.time.toDay().uppercased()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let tappedCell = collectionView.cellForItem(at: indexPath) else { return }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        collectionView.isScrollEnabled = false
        
        let modalView = WVModalView(frame: tappedCell.frame)
        modalView.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        collectionView.addSubview(modalView)
        collectionView.bringSubview(toFront: modalView)
        
        currentModalView = modalView
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modalView.widthAnchor.constraint(equalToConstant: tappedCell.frame.width).isActive = true
        
        // modal view weather info
        guard let cellIndex = collectionView.indexPath(for: tappedCell)?.item else { return }
        
        let weather = weeklyWeather[cellIndex]
        
        // table view delegate and datasource
        modalView.tableView.delegate = self
        modalView.tableView.dataSource = self
        modalView.tableView.register(DailyWeatherDetailCell.self, forCellReuseIdentifier: "DailyWeatherDetailCell")
        
        modalView.dayLabel.text = cellIndex == 0 ? "TODAY" : weather.time.toDay().uppercased()
        modalView.summaryLabel.text = weather.summary
        modalView.imageView.image = UIImage(named: weather.icon.getSummaryCode())
        
        UIView.animate(withDuration: 0.5) {
            modalView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 40).isActive = true
            collectionView.layoutSubviews()
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

////////////////////////////////////////////////////////
// MARK: TABLE VIEW STUFF
////////////////////////////////////////////////////////

extension WeeklyController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SECTION"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherDetailCell", for: indexPath) as? DailyWeatherDetailCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

























