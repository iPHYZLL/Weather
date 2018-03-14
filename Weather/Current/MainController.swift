//
//  MainController.swift
//  Weather
//
//  Created by Alen Kirm on 7. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import CoreLocation

class MainController: UIViewController {
    
    // properties
    
    var locationManager : CLLocationManager!
    
    var weather : Weather? {
        didSet {
            // update layout ...
            DispatchQueue.main.async {
                self.updateLayoutForWeather(weather: self.weather!)
            }
        }
    }
    
    var currentLocation : CLLocation? {
        didSet {
            
            if let location = currentLocation {
                UserLocation.shared.latitude = location.coordinate.latitude
                UserLocation.shared.longitude = location.coordinate.longitude
                
                location.getCurrentCity(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (cityName) in
                    self.navigationItem.title = cityName
                }
                
                requestWeather(withUrl: WEATHER_URL_REQUEST)
            }
        }
    }
    
    // views
    
    let contentView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedWhite
        return v
    }()
    
    var weatherTypeLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "PARTLY CLOUDY"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 30)
        return l
    }()

    var weatherImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Default")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true // just in case
        return iv
    }()
    
    var temperatureLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "25°"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 48)
        return l
    }()
    
    let detailsLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "DETAILS"
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .center
        return l
    }()
    
    let separatorDetailsLine : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedBlue
        return v
    }()
    
    let feelsLikeLabel : UILabel = {
        let l = UILabel()
        l.text = "FEELS LIKE"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.themedBlack
        return l
    }()
    
    let feelsLikeValueLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "25°"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let humidityLabel : UILabel = {
        let l = UILabel()
        l.text = "HUMIDITY"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.themedBlack
        return l
    }()
    
    let humidityValueLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "55%"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let windSpeedLabel : UILabel = {
        let l = UILabel()
        l.text = "WIND SPEED"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.themedBlack
        return l
    }()
    
    let windSpeedValueLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "15.7 Km/h"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let windDirectionLabel : UILabel = {
        let l = UILabel()
        l.text = "DIRECTION"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.themedBlack
        return l
    }()
    
    let windDirectionValueLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "North"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let visibilityLabel : UILabel = {
        let l = UILabel()
        l.text = "VISIBILITY"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.themedBlack
        return l
    }()
    
    let visibilityValueLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.text = "17 km"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let weeklyWeatherButton : WCButton = {
        let b = WCButton()
        b.setTitle("WEEKLY", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.addTarget(self, action: #selector(weeklyButtonPressed(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    @objc func weeklyButtonPressed(sender : UIButton) {
        sender.backgroundColor = UIColor.themedBlue
        sender.setTitleColor(UIColor.themedWhite, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add configured core location manager
        configureCoreLocation()
        
        view.backgroundColor = UIColor.themedWhite
        self.navigationItem.title = "WEATHER"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchTapped))
        
        // add subviews
        layoutViews()
        
    }
    
    @objc func handleSearchTapped() {
        
        let searchController = SearchCityController()
        searchController.navigationItem.title = "SEARCH CITY"
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController?.pushViewController(searchController, animated: true)
        
    }
    
    fileprivate func updateLayoutForWeather(weather : Weather) {
        
        let currentWeather = weather.currently
        print(currentWeather)
        
        for daily in weather.daily.data {
            let date = Date(timeIntervalSince1970: Double(daily.time))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .full
            
            let localDate = dateFormatter.string(from: date)
            print(localDate)
        }
        
        weatherTypeLabel.text = currentWeather.summary
        weatherImageView.image = UIImage(named: currentWeather.icon.getSummaryCode())
        temperatureLabel.text = "\(currentWeather.temperature.rounded())°"
        feelsLikeValueLabel.text = "\(currentWeather.apparentTemperature.rounded())°"
        humidityValueLabel.text = currentWeather.humidity.toPercent()
        windSpeedValueLabel.text = currentWeather.windSpeed.rounded().doubleToString(with: "Km/h")
        windDirectionValueLabel.text = currentWeather.windBearing.toCompass()
        visibilityValueLabel.text = currentWeather.visibility.rounded().doubleToString(with: "km")
        
        for subView in contentView.subviews {
            UIView.animate(withDuration: 0.5) {
                subView.alpha = 1
            }
        }
        
    }
    
    fileprivate func requestWeather(withUrl url : String) {
        
        guard let requestUrl = URL(string: url) else { return }
    
        URLSession.shared.dataTask(with: requestUrl) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                self.weather = try JSONDecoder().decode(Weather.self, from: data)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    fileprivate func configureCoreLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // reduce for energy saving ?
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startMonitoringSignificantLocationChanges()
        }
        
    }
    
    fileprivate func layoutViews() {
        
        view.addSubview(contentView)
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        view.layoutIfNeeded()
        
        let thirdHeightOfContentView = (contentView.frame.height - navigationController!.navigationBar.frame.height) / 3
        
        contentView.addSubview(weatherTypeLabel)
        weatherTypeLabel.anchor(top: contentView.topAnchor, paddingTop: 20, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: nil, paddingBottom: 0, width: 0, height: 40)
        
        contentView.addSubview(weatherImageView)
        weatherImageView.anchor(top: weatherTypeLabel.bottomAnchor, paddingTop: -20, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: thirdHeightOfContentView, height: thirdHeightOfContentView)
        weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        contentView.addSubview(weeklyWeatherButton)
        weeklyWeatherButton.anchor(top: nil, paddingTop: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: contentView.bottomAnchor, paddingBottom: 20, width: 200, height: 40)
        weeklyWeatherButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weeklyWeatherButton.layer.cornerRadius = 20

        // details stuff
        
        contentView.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: weatherImageView.bottomAnchor, paddingTop: -20, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
        contentView.addSubview(detailsLabel)
        detailsLabel.anchor(top: temperatureLabel.bottomAnchor, paddingTop: 10, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        contentView.addSubview(separatorDetailsLine)
        separatorDetailsLine.anchor(top: detailsLabel.bottomAnchor, paddingTop: 10, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 75, height: 2)
        separatorDetailsLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        let detailsLeftStackView = UIStackView(arrangedSubviews: [feelsLikeLabel, humidityLabel, windSpeedLabel, windDirectionLabel, visibilityLabel])
        detailsLeftStackView.axis = .vertical
        detailsLeftStackView.distribution = .fillEqually

        let detailsRightStackView = UIStackView(arrangedSubviews: [feelsLikeValueLabel, humidityValueLabel, windSpeedValueLabel, windDirectionValueLabel, visibilityValueLabel])
        detailsRightStackView.axis = .vertical
        detailsRightStackView.distribution = .fillEqually

        let detailsCombinedStackView = UIStackView(arrangedSubviews: [detailsLeftStackView, detailsRightStackView])
        detailsCombinedStackView.distribution = .fillProportionally

        contentView.addSubview(detailsCombinedStackView)
        detailsCombinedStackView.anchor(top: separatorDetailsLine.bottomAnchor, paddingTop: 10, right: weatherImageView.rightAnchor, paddingRight: 0, left: weatherImageView.leftAnchor, paddingLeft: 0, bottom: weeklyWeatherButton.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        for subView in contentView.subviews {
            subView.alpha = 0
        }
        
    }
    
}

// core location stuff ...
extension MainController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.first
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error.localizedDescription)")
    }
    
}








