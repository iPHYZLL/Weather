//
//  Urls.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

let WEATHER_API_KEY = "b85fa84cfbc486ef6baaadc810ea7e37"
let PLACES_API_KEY = "AIzaSyAHOy43TVZFfQJRh_nYIay_WYlHVxKtoiM"

let WEATHER_URL_REQUEST = "https://api.darksky.net/forecast/\(WEATHER_API_KEY)/\(UserLocation.shared.latitude!),\(UserLocation.shared.longitude!)?units=si"

