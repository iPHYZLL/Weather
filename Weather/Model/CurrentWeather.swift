//
//  CurrentWeather.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

struct CurrentWeather : Codable {
    
    let summary : String
    let icon : String
    let temperature : Double
    let apparentTemperature : Double
    let humidity : Double
    let windSpeed : Double
    let windBearing : Int
    let visibility : Double
    
}
