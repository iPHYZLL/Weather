//
//  Weather.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

struct Weather : Codable {
    
    let currently : CurrentWeather
    let daily : DailyData
    
}

struct DailyData : Codable {
    
    let data : [DailyWeather]
    
}
