//
//  WCButton.swift
//  Weather
//
//  Created by Alen Kirm on 9. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class WCButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.themedBlue
        setTitleColor(UIColor.themedWhite, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        layer.borderColor = UIColor.themedBlue.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            UIView.animate(withDuration: 0.25) {
                self.setTitleColor(self.isHighlighted ? UIColor.themedBlue : UIColor.themedWhite, for: .normal)
                self.backgroundColor = self.isHighlighted ? UIColor.clear : UIColor.themedBlue
            }
            
        }
    }
    
}
