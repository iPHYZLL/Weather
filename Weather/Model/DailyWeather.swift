//
//  DailyWeather.swift
//  Weather
//
//  Created by Alen Kirm on 12. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

struct DailyWeather : Codable {
    
    let summary : String
    let icon : String
    let time : Int
    let humidity : Double
    let windSpeed : Double
    let windBearing : Int
    let temperatureHigh : Double
    let temperatureHighTime : Int
    let temperatureLow : Double
    let temperatureLowTime : Int
    
}
