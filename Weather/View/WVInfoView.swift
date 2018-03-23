//
//  WVInfoView.swift
//  Weather
//
//  Created by Alen Kirm on 20. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

enum WVInfoViewStyle {
    case horizontal
    case vertical
}

class WVInfoView : UIView {
    
    var name : String?
    var value : String?
    
    let textLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        
        return l
    }()
    
    let separator : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedBlue
        return v
    }()
    
    let nameLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let valueLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.numberOfLines = 0
        return l
    }()
    
    let padding : CGFloat = 20
    
    init(style : WVInfoViewStyle) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.themedWhite
        layer.cornerRadius = 10
        
        // add subviews
        addSubview(nameLabel)
        addSubview(valueLabel)
        
        // constrain subviews
        // if vertical
        if style == .vertical {
            
            nameLabel.anchor(top: nil, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: centerYAnchor, paddingBottom: 4, width: 0, height: 20)
            
            addSubview(separator)
            separator.anchorCenter(to: self, withHeight: 2, andWidth: 50)
            separator.layer.cornerRadius = 1
            
            valueLabel.anchor(top: centerYAnchor, paddingTop: 4, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        } else {
            
            nameLabel.anchor(top: nil, paddingTop: 0, right: centerXAnchor, paddingRight: 5, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 20)
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            valueLabel.anchor(top: nil, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: centerXAnchor, paddingLeft: 5, bottom: nil, paddingBottom: 0, width: 0, height: self.frame.height)
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        }
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
