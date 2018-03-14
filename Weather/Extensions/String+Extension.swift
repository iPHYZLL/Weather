//
//  String+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 9. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func getSummaryCode() -> String {
        if self == "clear-day" || self == "clear-night" {
            return "Clear"
        } else if self == "rain" {
            return "Rain"
        } else if self == "wind" {
            return "Wind"
        } else if self == "fog" {
            return "Fog"
        } else if self == "cloudy" {
            return "Cloudy"
        } else if self == "partly-cloudy-day" || self == "partly-cloudy-night" {
            return "Partly Cloudy"
        } else {
            return "Default"
        }
    }
    
}
