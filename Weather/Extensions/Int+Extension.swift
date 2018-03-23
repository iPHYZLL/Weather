//
//  Int+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 9. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    func toCompass() -> String {
        if self >= 330 && self <= 30 {
            return "North"
        } else if self > 300 && self < 330 {
            return "Northwest"
        } else if self > 30 && self < 60 {
            return "Northeast"
        } else if self >= 60 && self <= 120 {
            return "East"
        } else if self > 120 && self < 150 {
            return "Southeast"
        } else if self >= 150 && self <= 210 {
            return "South"
        } else if self > 210 && self < 240 {
            return "Southwest"
        } else {
            return "West"
        }
    }
    
    func toHour() -> String {
        
        let date = Date(timeIntervalSince1970: Double(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let formatedDate = dateFormatter.string(from: date)
        
        return formatedDate
    }
    
    func toDay() -> String {
        
        let date = Date(timeIntervalSince1970: Double(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let formatedDate = dateFormatter.string(from: date)
        
        return formatedDate
    }
    
}
