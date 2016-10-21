//
//  CalculatorController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class NumberController {
    
    // MARK: - Shared Instance
    static let sharedController = NumberController()
    
    // MARK: - Class Instances
    var number = Number()
    var stack = Stack()
    
    // MARK: - Computed Properties
    var currentlyTypingNumber: Bool {
        get {
            return number.currentlyTypingNumber
        } set {
            number.currentlyTypingNumber = newValue
        }
    }
    
    // MARK: - Controller Functions
    
    ///Run operation by passing in an operator string.
    func runOperation(operatorString: String) {
        
        let operation = operatorString
        
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
    
    ///Converts a passed in number into a percentage and returns the value
    func percentage(currentNumber: Double) -> Double {
        
        let firstNumber = stack.pop()!
        
        let decimalNumber = firstNumber / 100
        let percentnumber = decimalNumber * currentNumber
        stack.push(number: firstNumber)
        
        return percentnumber
    }
    
    ///Add a passed in number to the stack and prints the current stack
    func enter(currentNumber: Double) {
        
        stack.push(number: currentNumber)
        stack.log()
    }
    
    ///Delete all objects from the stack
    func delete() {
        
        stack.clearStack()
        stack.log()
        number.resultNumber = 0
    }
    
}
