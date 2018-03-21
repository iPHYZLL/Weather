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
    
    let collectionViewContentView : UIView = {
        let v = UIView()
        return v
    }()
    
    let padding : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.themedWhite
        
        // add content view for collection view
        view.addSubview(collectionViewContentView)
        collectionViewContentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: padding, right: view.rightAnchor, paddingRight: padding, left: view.leftAnchor, paddingLeft: padding, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        
        // add collection view to contentView and configure it (register cell, delegate, data source etc)
        configureCollectionView()
        
    }
    
    fileprivate func configureCollectionView() {
        
        collectionViewContentView.addSubview(collectionView)
        collectionView.anchor(top: collectionViewContentView.topAnchor, paddingTop: 0, right: collectionViewContentView.rightAnchor, paddingRight: 0, left: collectionViewContentView.leftAnchor, paddingLeft: 0, bottom: collectionViewContentView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
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
        
        cell.imageView.image = UIImage(named: weather.icon?.getSummaryCode() ?? "")
        cell.summaryLabel.text = weather.summary
        cell.highTempLabel.text = "\(weather.temperatureHigh?.rounded() ?? 0.0)°"
        cell.highTempTimeLabel.text = weather.temperatureHighTime?.toHour()
        cell.lowTempLabel.text = "\(weather.temperatureLow?.rounded() ?? 0.0)°"
        cell.lowTempTimeLabel.text = weather.temperatureLowTime?.toHour()
        cell.dayLabel.text = indexPath.item == 0 ? "TODAY" : weather.time?.toDay().uppercased()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let tappedCell = collectionView.cellForItem(at: indexPath) else { return }
        
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        collectionView.isScrollEnabled = false
        
        let modalView = WVModalView(frame: tappedCell.frame)
        modalView.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        collectionView.addSubview(modalView)
        collectionView.bringSubview(toFront: modalView)
        
        currentModalView = modalView
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.centerXAnchor.constraint(equalTo: collectionViewContentView.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: collectionViewContentView.centerYAnchor).isActive = true
        modalView.widthAnchor.constraint(equalTo: collectionViewContentView.widthAnchor).isActive = true
        modalView.heightAnchor.constraint(equalTo: self.collectionViewContentView.heightAnchor).isActive = true
        
        // modal view weather info
        guard let cellIndex = collectionView.indexPath(for: tappedCell)?.item else { return }
        
        let weather = weeklyWeather[cellIndex]
        
        modalView.dayLabel.text = cellIndex == 0 ? "TODAY" : weather.time?.toDay().uppercased() ?? "nil"
        modalView.summaryLabel.text = weather.summary
        modalView.imageView.image = UIImage(named: weather.icon?.getSummaryCode() ?? "")
        
        // max temp
        modalView.maxTempView.nameLabel.text = "HIGH TEMP"
        modalView.maxTempView.valueLabel.text = "\(weather.temperatureHigh?.rounded() ?? 0.0)° at \(weather.temperatureHighTime?.toHour() ?? "0:0")"
        
        // min temp
        modalView.minTempView.nameLabel.text = "LOW TEMP"
        modalView.minTempView.valueLabel.text = "\(weather.temperatureLow?.rounded() ?? 0.0)° at \(weather.temperatureLowTime?.toHour() ?? "0:0")"
        
        // wind info
        modalView.windView.nameLabel.text = "WIND"
        modalView.windView.valueLabel.text = "\(weather.windSpeed?.rounded().doubleToString(with: "Km/h") ?? "0 Km/h") from \(weather.windBearing?.toCompass() ?? "")"
        
        // humidity
        modalView.humidityView.nameLabel.text = "HUMIDITY"
        modalView.humidityView.valueLabel.text = weather.humidity?.toPercent() ?? "0 %"
        
        // visibility
        modalView.visibilityView.nameLabel.text = "VISIBILITY"
        modalView.visibilityView.valueLabel.text = weather.visibility?.rounded().doubleToString(with: "km") ?? "0 km"
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
























