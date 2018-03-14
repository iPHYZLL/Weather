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
    
    let containerScrollView : UIScrollView = {
        let cv = UIScrollView()
        cv.backgroundColor = UIColor.themedBlue
        return cv
    }()
    
    let containerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.themedOrange
        return cv
    }()
    
    let tableView : UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.bounces = false
        return tv
    }()
    
    let padding : CGFloat = 20
    
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
        
        addSubview(tableView)
        tableView.anchor(top: imageView.bottomAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = UIColor.themedGray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
