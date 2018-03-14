//
//  CLLocation+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 9. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    func getCurrentCity(latitude : Double, longitude : Double, completion: @escaping (_ city : String) ->()){
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarkArray, error) in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let placemarks = placemarkArray {
                
                if let placemark = placemarks.first {
                    
                    if let cityName = placemark.thoroughfare {
                        completion(cityName)
                    }
                    
                }
            }
            
        }
    }
    
}

