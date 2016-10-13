//
//  CalculatorController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class NumberController {
    
    static let sharedController = NumberController()
    
    var number: Number?
    var stack = Stack()
    
    var result: Double {
        get {
            guard let number = number else { return 0 }
            return number.result
        }
        set {
            guard let number = number else { return }
            number.result = newValue
        }
    }

    var operation: String {
        get {
            guard let number = number,
                let currentOperator = number.currentOperation else { return "" }
            return currentOperator
        }
        set {
            guard let number = number else { return }
            number.currentOperation = newValue
        }
    }
    
    var currentlyTypingNumber: Bool {
        guard let number = number else { return false }
        
        return number.currentlyTypingNumber
    }
    
    
    func setOperator(operatorString: String) {
        
        
        if stack.count() >= 2 {
            
            let double1 = stack.pop()!
            let double2 = stack.pop()!
        
            switch operation {
                
                case "+":
                    result = double2 + double1
                case "-":
                    result = double2 - double1
                case "x":
                    result = double2 * double1
                case "÷":
                    result = double2 / double1
            default:
                stack.push(number: double1)
                stack.push(number: double2)
            }
            
        }
    }
    
    func enter(currentNumber: Double) {
        
        stack.push(number: currentNumber)
        stack.log()
    }
    
    func delete() {
        
        stack.clearStack()
        stack.log()
        result = 0
    }
    
}
