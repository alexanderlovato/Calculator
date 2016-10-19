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
    
    var number = Number()
    
    var stack = Stack()
        
    var currentlyTypingNumber: Bool {
        get {
            return number.currentlyTypingNumber
        } set {
            number.currentlyTypingNumber = newValue
        }
    }
    
    
    func setOperator(operatorString: String) {
        
        let operation = number.operation
        
        if stack.count() >= 2 {
            
            let double1 = stack.pop()!
            let double2 = stack.pop()!
        
            switch operation {
                
                case "+":
                    number.resultNumber = double2 + double1
                case "-":
                    number.resultNumber = double2 - double1
                case "x":
                    number.resultNumber = double2 * double1
                case "÷":
                    number.resultNumber = double2 / double1
            default:
                stack.push(number: double1)
                stack.push(number: double2)
            }
            
        }
    }
    
    func percentage(currentNumber: Double) -> Double {
        
        let firstNumber = stack.pop()!
        
        let decimalNumber = firstNumber / 100
        let percentnumber = decimalNumber * currentNumber
        stack.push(number: firstNumber)
        
        return percentnumber
    }
    
    func enter(currentNumber: Double) {
        
        stack.push(number: currentNumber)
        stack.log()
    }
    
    func delete() {
        
        stack.clearStack()
        stack.log()
        number.resultNumber = 0
    }
    
}
