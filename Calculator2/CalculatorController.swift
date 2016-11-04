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
    var stack = [Any]()
    
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
    func runOperation(stackToUse: [Any]) -> Double {
        var operationStack = stackToUse
        for _ in operationStack {
            //guard let item = item as? String else { continue }
            
            for (index, item) in operationStack.enumerated() {
                guard let item = item as? String else { continue }
                if item == "*" {
                    let first = operationStack[index - 1] as! Double //6
                    let second = operationStack[index + 1] as! Double //2
                    operationStack[index - 1] = first * second //replace 6 with 12
                    operationStack.remove(at: index) //delete *
                    operationStack.remove(at: index) //delete 2
                    break
                } else if item == "÷" {
                    let first = operationStack[index - 1] as! Double
                    let second = operationStack[index + 1] as! Double
                    operationStack[index - 1] = first / second
                    operationStack.remove(at: index)
                    operationStack.remove(at: index)
                    break
                }
            }
        }
        
        for _ in operationStack {
            //guard let item = item as? String else { continue }
            for (index, item) in operationStack.enumerated() {
                guard let item = item as? String else { continue }
                if item == "+" {
                    let first = operationStack[index - 1] as! Double
                    let second = operationStack[index + 1] as! Double
                    operationStack[index - 1] = first + second
                    operationStack.remove(at: index)
                    operationStack.remove(at: index)
                    break
                } else if item == "-" {
                    let first = operationStack[index - 1] as! Double
                    let second = operationStack[index + 1] as! Double
                    operationStack[index - 1] = first - second
                    operationStack.remove(at: index)
                    operationStack.remove(at: index)
                    break
                }
            }
        }
        let returnNumber = operationStack.removeLast() as! Double
        return returnNumber
        
    }
    
    ///Converts a passed in number into a percentage and returns the value
    func percentage(currentNumber: Double) -> Double {
        
        if stack.count > 3 {
            var tempStack = stack
            _ = tempStack.removeLast()
            let stackSum = runOperation(stackToUse: tempStack)
            let decimalNumber = stackSum / 100
            let percentnumber = decimalNumber * currentNumber
            return percentnumber
        } else {
            let holdOperator = stack.removeLast()
            let firstNumber = stack.removeLast() as! Double
            let decimalNumber = firstNumber / 100
            let percentnumber = decimalNumber * currentNumber
            enter(addToStack: firstNumber)
            enter(addToStack: holdOperator)
            return percentnumber
        }
        
    }
    
    ///Add a passed in number to the stack and prints the current stack
    func enter(addToStack: Any) {
        stack.append(addToStack)
        print(stack)
    }
    
    ///Delete all objects from the stack
    func delete() {
        stack.removeAll()
        print(stack)
        number.resultNumber = 0
    }
    
}
