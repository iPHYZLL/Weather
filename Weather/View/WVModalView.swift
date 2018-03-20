//
//  WVCustomView.swift
//  Weather
//
//  Created by Alen Kirm on 13. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class WVModalView: UIView {
    
    let closeButton : UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        b.contentMode = .scaleAspectFit
        b.tintColor = UIColor.themedBlue
        return b
    }()
    
    let dayLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textAlignment = .center
        l.text = "WEDNESDAY"
        return l
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let summaryLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let maxTemperatureName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "HIGH TEMPERATURE"
        return l
    }()
    
    let maxTemperatureValue : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "20° at 16:00"
        return l
    }()
    
    let minTemperatureName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "LOW TEMPERATURE"
        return l
    }()
    
    let minTemperatureValue : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "0° at 01:00"
        return l
    }()
    
    let windName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "WIND"
        return l
    }()
    
    let windValue : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let humidityName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "HUMIDITY"
        return l
    }()
    
    let humidityValue : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let visibilityName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "VISIBILITY"
        return l
    }()
    
    let visibilityValue : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let padding : CGFloat = 20
    let stackViewSpacing : CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.themedGray
        layer.cornerRadius = 10
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 20, height: 20)
        
        addSubview(dayLabel)
        dayLabel.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        addSubview(imageView)
        imageView.anchor(top: dayLabel.bottomAnchor, paddingTop: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: (frame.height / 3) * 2, height: (frame.height / 3) * 2)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(summaryLabel)
        summaryLabel.anchor(top: imageView.bottomAnchor, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 50)

        ////////////////////////////////////////////////////////
        // MARK: stackviews
        ////////////////////////////////////////////////////////
        
        let maxTempStackView = UIStackView(arrangedSubviews: [maxTemperatureName, maxTemperatureValue])
        maxTempStackView.distribution = .fillEqually
        maxTempStackView.axis = .vertical
        
        let minTempStackView = UIStackView(arrangedSubviews: [minTemperatureName, minTemperatureValue])
        minTempStackView.distribution = .fillEqually
        minTempStackView.axis = .vertical
        
        let windStackView = UIStackView(arrangedSubviews: [windName, windValue])
        windStackView.distribution = .fillEqually
        windStackView.axis = .vertical

        let humidityStackView = UIStackView(arrangedSubviews: [humidityName, humidityValue])
        humidityStackView.distribution = .fillEqually
        humidityStackView.axis = .vertical
        
        let visibilityStackView = UIStackView(arrangedSubviews: [visibilityName, visibilityValue])
        visibilityStackView.distribution = .fillEqually
        visibilityStackView.axis = .vertical
        
        let weatherStackView = UIStackView(arrangedSubviews: [maxTempStackView, minTempStackView, windStackView, humidityStackView, visibilityStackView])
        weatherStackView.distribution = .fillEqually
        weatherStackView.spacing = stackViewSpacing
        weatherStackView.axis = .vertical
        
        
        addSubview(weatherStackView)
        weatherStackView.anchor(top: summaryLabel.bottomAnchor, paddingTop: padding, right: summaryLabel.rightAnchor, paddingRight: 0, left: summaryLabel.leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: padding, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
