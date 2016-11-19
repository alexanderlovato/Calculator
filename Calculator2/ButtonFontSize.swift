//
//  ButtonFontSize.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/19/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class ButtonFontSize: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        titleLabel?.minimumScaleFactor = 0
    }

}
