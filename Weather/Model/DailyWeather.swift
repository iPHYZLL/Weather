//
//  DailyWeather.swift
//  Weather
//
//  Created by Alen Kirm on 12. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

struct DailyWeather : Codable {
    
    var summary : String?
    var icon : String?
    var time : Int?
    var humidity : Double?
    var windSpeed : Double?
    var windBearing : Int?
    var temperatureHigh : Double?
    var temperatureHighTime : Int?
    var temperatureLow : Double?
    var temperatureLowTime : Int?
    var visibility : Double?
    
}
