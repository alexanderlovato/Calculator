//
//  Calculator.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class Number {
    
    var result: Double
    var currentOperation: String?
    var currentlyTypingNumber: Bool
    
    init(result: Double, currentOperation: String?, currentlyTypingNumber: Bool) {
        self.result = result
        self.currentOperation = currentOperation
        self.currentlyTypingNumber = currentlyTypingNumber
    }
    
}
