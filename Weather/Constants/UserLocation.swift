//
//  UserLocation.swift
//  Weather
//
//  Created by Alen Kirm on 8. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation {
    
    static var shared = UserLocation()
    
    var latitude : Double!
    var longitude : Double!
    
    fileprivate init() {}
    
}
