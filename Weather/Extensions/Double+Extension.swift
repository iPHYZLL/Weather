//
//  Double+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 9. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

extension Double {
    
    func toPercent() -> String {
        return "\((self / 1.0) * 100) %"
    }
    
    func doubleToString(withDecimalPlaces x : Int) -> String {
        return String(format: "%.\(x)f", arguments: [self])
    }
    
    func doubleToString(with character : String) -> String {
        return "\(self) \(character)"
    }
    
}
