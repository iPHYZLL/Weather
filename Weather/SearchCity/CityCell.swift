//
//  CityCell.swift
//  Weather
//
//  Created by Alen Kirm on 21. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class CityCell : UITableViewCell {
    
    let cityName : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = UIColor.themedBlack
        l.textAlignment = .center
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.themedGray
        layer.cornerRadius = 10
        
        selectionStyle = .none
        
        addSubview(cityName)
        cityName.anchorCenter(to: self, withHeight: frame.height, andWidth: frame.width)
        
    }
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
