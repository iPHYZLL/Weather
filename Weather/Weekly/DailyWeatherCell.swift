//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Alen Kirm on 12. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {

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
    
    let dayLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .center
        l.text = "WEDNESDAY"
        return l
    }()

    
    let highTempTimeLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let highTempLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 26)
        return l
    }()
    
    let lowTempTimeLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let lowTempLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.themedBlack
        l.font = UIFont.boldSystemFont(ofSize: 26)
        return l
    }()
    
    let separatorLineHigh : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedBlue
        return v
    }()
    
    let separatorLineLow : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.themedBlue
        return v
    }()
    
    var padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.0625
        layer.borderColor = UIColor.themedLightGray.cgColor
        
        backgroundColor = UIColor.themedLightGray
        
        layoutSubviews()
        
        layoutViews()
        
    }
    
    fileprivate func layoutViews() {
        
        let thirdWidth = frame.width / 3
        addSubview(imageView)
        
        
        // add day label
        addSubview(dayLabel)
        dayLabel.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        // add image
        
        imageView.anchor(top: dayLabel.bottomAnchor, paddingTop: padding, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: thirdWidth, height: thirdWidth)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // add high temp views
        
        addSubview(separatorLineHigh)
        separatorLineHigh.anchor(top: nil, paddingTop: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: thirdWidth / 3, height: 2)
        separatorLineHigh.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        addSubview(highTempLabel)
        highTempLabel.anchor(top: nil, paddingTop: 0, right: imageView.leftAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: padding, bottom: separatorLineHigh.topAnchor, paddingBottom: padding, width: 0, height: 25)
        
        separatorLineHigh.centerXAnchor.constraint(equalTo: highTempLabel.centerXAnchor).isActive = true
        
        addSubview(highTempTimeLabel)
        highTempTimeLabel.anchor(top: separatorLineHigh.bottomAnchor, paddingTop: padding, right: highTempLabel.rightAnchor, paddingRight: 0, left: highTempLabel.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        // add low temp views
        
        addSubview(separatorLineLow)
        separatorLineLow.anchor(top: nil, paddingTop: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: thirdWidth / 3, height: 2)
        separatorLineLow.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        addSubview(lowTempLabel)
        lowTempLabel.anchor(top: nil, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: imageView.rightAnchor, paddingLeft: 0, bottom: separatorLineLow.topAnchor, paddingBottom: padding, width: 0, height: 25)
        
        separatorLineLow.centerXAnchor.constraint(equalTo: lowTempLabel.centerXAnchor).isActive = true
        
        addSubview(lowTempTimeLabel)
        lowTempTimeLabel.anchor(top: separatorLineLow.bottomAnchor, paddingTop: padding, right: lowTempLabel.rightAnchor, paddingRight: 0, left: lowTempLabel.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        // add other views
        
        addSubview(summaryLabel)
        summaryLabel.anchor(top: imageView.bottomAnchor, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: bottomAnchor, paddingBottom: padding, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
