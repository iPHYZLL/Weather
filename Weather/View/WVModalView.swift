//
//  WVCustomView.swift
//  Weather
//
//  Created by Alen Kirm on 13. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class WVModalView: UIView {
    
    var superCollectionView : UICollectionView? {
        didSet {
            print(superCollectionView!)
        }
    }
    
    let closeButton : UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        b.contentMode = .scaleAspectFit
        b.tintColor = UIColor.themedBlue
        return b
    }()
    
    let padding : CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.themedGray
        layer.cornerRadius = 10
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, paddingTop: padding, right: rightAnchor, paddingRight: padding, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 20, height: 20)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
