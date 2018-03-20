//
//  DailyWeatherDetailCell.swift
//  Weather
//
//  Created by Alen Kirm on 14. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class DailyWeatherDetailCell : UITableViewCell {
    
    let infoTitleLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .left
        l.text = "DIRECTION"
        l.textColor = UIColor.themedBlack
        return l
    }()

    let infoValueLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .right
        l.textColor = UIColor.themedBlack
        l.text = "1.0 Km/h"
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.themedGray
        
        
        addSubview(infoTitleLabel)
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        infoTitleLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(infoValueLabel)
        infoValueLabel.translatesAutoresizingMaskIntoConstraints = false
        infoValueLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoValueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        infoValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
