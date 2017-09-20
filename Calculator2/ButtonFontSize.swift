//
//  ButtonFontSize.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/19/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class ButtonFontSize: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        titleLabel?.minimumScaleFactor = 0
    }

}
