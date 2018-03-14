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
        
        setTitleColor(UIColor.themedBlue, for: .normal)
        layer.borderColor = UIColor.themedBlue.cgColor
        layer.borderWidth = 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            UIView.animate(withDuration: 0.25) {
                self.setTitleColor(self.isHighlighted ? UIColor.themedWhite : UIColor.themedBlue, for: .normal)
                self.backgroundColor = self.isHighlighted ? UIColor.themedBlue : UIColor.themedWhite
            }
            
        }
    }
    
}
