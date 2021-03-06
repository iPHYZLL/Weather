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
    
    var customCityName : String? {
        didSet {
            
            guard let selectedName = customCityName else { return }
            
            getCoordinates(cityName: selectedName) { (coordinates) in
                
                let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                
                self.currentLocation = location
                
            }
        }
    }
    
    func getCoordinates(cityName : String, completion : @escaping (CLLocationCoordinate2D) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            
            if error == nil {
                if let placemark = placemarks?.first {
                    let location = placemark.location!
                    
                    completion(location.coordinate)
                    return
                }
            }
            
            completion(kCLLocationCoordinate2DInvalid)
        }
    }
    
    var weather : Weather? {
        
        didSet {
            
            DispatchQueue.main.async {
                self.updateLayoutForWeather(weather: self.weather!)
            }
            // update array of weekly weather
            var weeklyWeatherData = [DailyWeather]()
            
            for dailyWeather in weather!.daily.data {
                
                let daily = DailyWeather(summary: dailyWeather.summary, icon: dailyWeather.icon, time: dailyWeather.time, humidity: dailyWeather.humidity, windSpeed: dailyWeather.windSpeed, windBearing: dailyWeather.windBearing, temperatureHigh: dailyWeather.temperatureHigh, temperatureHighTime: dailyWeather.temperatureHighTime, temperatureLow: dailyWeather.temperatureLow, temperatureLowTime: dailyWeather.temperatureLowTime, visibility: dailyWeather.visibility)
                
                weeklyWeatherData.append(daily)
            }
            
            self.weeklyWeather = weeklyWeatherData
            
        }
    }
    
    var weeklyWeather : [DailyWeather]?
    
    var currentLocation : CLLocation? {
        didSet {
            if let location = currentLocation {
                if let customCity = customCityName {
                    DispatchQueue.main.async {
                        self.title = customCity.uppercased()
                    }
                } else {
                    location.getCurrentCity(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (cityName) in
                        self.title = cityName.uppercased()
                    }
                }
                
                DispatchQueue.global(qos: .userInteractive).sync {
                    
                    self.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    
                    if let fetchedWeather = self.weather {
                        DispatchQueue.main.async {
                            self.updateLayoutForWeather(weather: fetchedWeather)
                            
                        }
                    }
                    
                }
            }
        }
    }
    
    @objc fileprivate func showCurrent() {
        customCityName = nil
        currentLocation = locationManager.location
    }
    
    fileprivate func getWeather(latitude : Double, longitude : Double) {
        
        guard let requestUrl = URL(string: "https://api.darksky.net/forecast/\(WEATHER_API_KEY)/\(latitude),\(longitude)?units=si") else { return }
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
            if let err = error {
                print("Error while fetching weather data. ", err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                self.weather = try JSONDecoder().decode(Weather.self, from: data)
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }.resume()
        
    }
    
    fileprivate func updateLayoutForWeather(weather : Weather) {
        
        contentView.subviews.forEach { (view) in
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 0
            })
        }
        
        let currentWeather = weather.currently
        
        weatherTypeLabel.text = currentWeather.summary
        weatherImageView.image = UIImage(named: currentWeather.icon.getSummaryCode())
        temperatureLabel.text = "\(currentWeather.temperature.rounded())°"
        
        feelsLikeView.valueLabel.text = "\(currentWeather.apparentTemperature.rounded())°"
        humidityView.valueLabel.text = currentWeather.humidity.toPercent()
        windView.valueLabel.text = "\(currentWeather.windSpeed.rounded().doubleToString(with: "Km/h")) from \(currentWeather.windBearing.toCompass())"
        visibilityView.valueLabel.text = currentWeather.visibility.rounded().doubleToString(with: "km")
        
        contentView.subviews.forEach { (view) in
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 1
            })
        }
        
    }
    
    // views
    
    let contentView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedWhite
        return v
    }()
    
    let infoContainerView : UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
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
    
    let feelsLikeView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.horizontal)
        v.nameLabel.text = "FEELS LIKE"
        v.backgroundColor = UIColor.themedGray
        return v
    }()
    
    let windView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.horizontal)
        v.nameLabel.text = "WIND"
        v.backgroundColor = UIColor.themedGray
        return v
    }()
    
    let humidityView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.horizontal)
        v.nameLabel.text = "HUMIDITY"
        v.backgroundColor = UIColor.themedGray
        return v
    }()
    
    let visibilityView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.horizontal)
        v.nameLabel.text = "VISIBILITY"
        v.backgroundColor = UIColor.themedGray
        return v
    }()
    
    
    let weeklyWeatherButton : WCButton = {
        let b = WCButton()
        b.setTitle("WEEKLY", for: .normal)
        b.addTarget(self, action: #selector(weeklyButtonPressed(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add configured core location manager
        configureCoreLocation()
        
        view.backgroundColor = UIColor.themedWhite
        self.title = "WEATHER"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(handleSearchTapped))
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "refresh"), style: .plain, target: self, action: #selector(handleRefreshTapped))
        let locationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "location"), style: .plain, target: self, action: #selector(showCurrent))
        
        navigationItem.leftBarButtonItems = [refreshButton, locationButton]
        
        // add subviews
        layoutViews()
        
    }
    
    @objc func handleRefreshTapped() {
        
        guard let location = currentLocation else { return }
        
        DispatchQueue.main.async {
            self.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        } 
        
    }
    
    @objc func weeklyButtonPressed(sender : UIButton) {
        
        let weeklyController = WeeklyController()
        weeklyController.navigationItem.title = "WEEKLY"
        weeklyController.weeklyWeather = self.weeklyWeather

        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton

        navigationController?.pushViewController(weeklyController, animated: true)
        
    }
    
    @objc func handleSearchTapped() {
        
        let searchController = SearchCityController()
        searchController.navigationItem.title = "SEARCH CITY"
        searchController.delegate = self
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController?.pushViewController(searchController, animated: true)
        
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
        
        let thirdHeightOfContentView = (contentView.frame.height - navigationController!.navigationBar.frame.height) / 4
        
        contentView.addSubview(weatherTypeLabel)
        weatherTypeLabel.anchor(top: contentView.topAnchor, paddingTop: 20, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: nil, paddingBottom: 0, width: 0, height: 40)
        
        contentView.addSubview(weatherImageView)
        weatherImageView.anchor(top: weatherTypeLabel.bottomAnchor, paddingTop: -20, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: thirdHeightOfContentView, height: thirdHeightOfContentView)
        weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        contentView.addSubview(weeklyWeatherButton)
        weeklyWeatherButton.anchor(top: nil, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: contentView.bottomAnchor, paddingBottom: 20, width: 0, height: 40)

        // details stuff
        
        contentView.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: weatherImageView.bottomAnchor, paddingTop: -20, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
        contentView.addSubview(infoContainerView)
        infoContainerView.anchor(top: temperatureLabel.bottomAnchor, paddingTop: 20, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: weeklyWeatherButton.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        // info stackview
        
        let infoStackView = UIStackView(arrangedSubviews: [feelsLikeView, windView, humidityView, visibilityView])
        infoStackView.axis = .vertical
        infoStackView.spacing = 20
        infoStackView.distribution = .fillEqually
        
        infoContainerView.addSubview(infoStackView)
        infoStackView.anchor(top: infoContainerView.topAnchor, paddingTop: 0, right: infoContainerView.rightAnchor, paddingRight: 0, left: infoContainerView.leftAnchor, paddingLeft: 0, bottom: infoContainerView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
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

// search city stuff ...

extension MainController : SearchCityDelegate {
    func didSent(cityName: String) {
        customCityName = cityName
    }
}







