//
//  Calculator.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class Number {
    
    var result: Double?
    var currentOperation: String?
    var currentlyTypingNumber: Bool
    
    init(result: Double = 0, currentOperation: String = "", currentlyTypingNumber: Bool = false) {
        self.result = result
        self.currentOperation = currentOperation
        self.currentlyTypingNumber = currentlyTypingNumber
    }
    
    var resultNumber: Double {
        get {
            guard let result = result else { return 0 }
            return result
        } set {
            result = newValue
        }
    }
    
    var operation: String {
        get {
            guard let currentOperation = currentOperation else { return "" }
            return currentOperation
        } set {
            currentOperation = newValue
            
        }
    }
    
}
