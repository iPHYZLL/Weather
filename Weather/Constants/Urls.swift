//
//  Urls.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

let API_KEY = "b85fa84cfbc486ef6baaadc810ea7e37"

let WEATHER_URL_REQUEST = "https://api.darksky.net/forecast/b85fa84cfbc486ef6baaadc810ea7e37/\(UserLocation.shared.latitude!),\(UserLocation.shared.longitude!)?units=si"
