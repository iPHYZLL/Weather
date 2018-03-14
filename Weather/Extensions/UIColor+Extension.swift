//
//  UIColor+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 7. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let themedWhite = UIColor.rgb(red: 249, green: 249, blue: 249)
    
    static let themedBlack = UIColor.rgb(red: 25, green: 25, blue: 25)
    
    static let themedLightGray =  UIColor.rgb(red: 244, green: 244, blue: 244)
    
    static let themedGray = UIColor.rgb(red: 239, green: 239, blue: 239)
    
    static let themedBlue = UIColor.rgb(red: 74, green: 192, blue: 235)
    
    static let themedOrange = UIColor.rgb(red: 249, green: 174, blue: 77)
}
