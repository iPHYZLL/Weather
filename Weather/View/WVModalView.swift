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
    
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.layer.cornerRadius = 10
        return sv
    }()
    
    let containerView : UIView = {
        let v = UIView()
        return v
    }()
    
    let maxTempView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.vertical)
        return v
    }()
    
    let minTempView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.vertical)
        return v
    }()
    
    let windView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.vertical)
        return v
    }()
    
    let humidityView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.vertical)
        return v
    }()
    
    let visibilityView : WVInfoView = {
        let v = WVInfoView(style: WVInfoViewStyle.vertical)
        return v
    }()
    
    let padding : CGFloat = 20
    let stackViewSpacing : CGFloat = 10
    let viewHeight : CGFloat = 75
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.themedGray
        layer.cornerRadius = 10
        
        layoutUI()
        
    }
    
    fileprivate func layoutUI() {
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 20, height: 20)
        
        addSubview(dayLabel)
        dayLabel.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        addSubview(imageView)
        imageView.anchor(top: dayLabel.bottomAnchor, paddingTop: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: (frame.height / 3) * 2, height: (frame.height / 3) * 2)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(summaryLabel)
        summaryLabel.anchor(top: imageView.bottomAnchor, paddingTop: 0, right: rightAnchor, paddingRight: padding, left: leftAnchor, paddingLeft: padding, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
        addSubview(scrollView)
        scrollView.anchor(top: summaryLabel.bottomAnchor, paddingTop: padding, right: summaryLabel.rightAnchor, paddingRight: 0, left: summaryLabel.leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: padding, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, paddingTop: 0, right: scrollView.rightAnchor, paddingRight: 0, left: scrollView.leftAnchor, paddingLeft: 0, bottom: scrollView.bottomAnchor, paddingBottom: 0, width: 0, height: (5 * viewHeight) + (4 * 20))
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubview(maxTempView)
        maxTempView.anchor(top: containerView.topAnchor, paddingTop: 0, right: containerView.rightAnchor, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: viewHeight)
        
        containerView.addSubview(minTempView)
        minTempView.anchor(top: maxTempView.bottomAnchor, paddingTop: padding, right: containerView.rightAnchor, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: viewHeight)
        
        containerView.addSubview(windView)
        windView.anchor(top: minTempView.bottomAnchor, paddingTop: padding, right: containerView.rightAnchor, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: viewHeight)
        
        containerView.addSubview(humidityView)
        humidityView.anchor(top: windView.bottomAnchor, paddingTop: padding, right: containerView.rightAnchor, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: viewHeight)
        
        containerView.addSubview(visibilityView)
        visibilityView.anchor(top: humidityView.bottomAnchor, paddingTop: padding, right: containerView.rightAnchor, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: viewHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
