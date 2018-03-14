//
//  UIView+Extension.swift
//  Weather
//
//  Created by Alen Kirm on 7. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(top : NSLayoutYAxisAnchor?, paddingTop : CGFloat, right : NSLayoutXAxisAnchor?, paddingRight : CGFloat, left : NSLayoutXAxisAnchor?, paddingLeft : CGFloat, bottom :  NSLayoutYAxisAnchor?, paddingBottom : CGFloat, width : CGFloat, height : CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func anchorCenter(to view : UIView, withHeight height : CGFloat, andWidth width : CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
    func heightConstraint(height : CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    func widthConstraint(width : CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }
    
}
