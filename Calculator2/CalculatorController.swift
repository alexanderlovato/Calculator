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
    func runOperation() -> Double {
        for _ in stack {
            //guard let item = item as? String else { continue }
            
            for (index, item) in stack.enumerated() {
                guard let item = item as? String else { continue }
                if item == "*" {
                    let first = stack[index - 1] as! Double //6
                    let second = stack[index + 1] as! Double //2
                    stack[index - 1] = first * second //replace 6 with 12
                    stack.remove(at: index) //delete *
                    stack.remove(at: index) //delete 2
                    break
                } else if item == "/" {
                    let first = stack[index - 1] as! Double
                    let second = stack[index + 1] as! Double
                    stack[index - 1] = first / second
                    stack.remove(at: index)
                    stack.remove(at: index)
                    break
                }
            }
        }
        
        for _ in stack {
            //guard let item = item as? String else { continue }
            for (index, item) in stack.enumerated() {
                guard let item = item as? String else { continue }
                if item == "+" {
                    let first = stack[index - 1] as! Double
                    let second = stack[index + 1] as! Double
                    stack[index - 1] = first + second
                    stack.remove(at: index)
                    stack.remove(at: index)
                    break
                } else if item == "-" {
                    let first = stack[index - 1] as! Double
                    let second = stack[index + 1] as! Double
                    stack[index - 1] = first - second
                    stack.remove(at: index)
                    stack.remove(at: index)
                    break
                }
            }
        }
        let returnNumber = stack.removeLast() as! Double
        return returnNumber
        
    }
    
    ///Converts a passed in number into a percentage and returns the value
    func percentage(currentNumber: Double) -> Double {
        
        let firstNumber = stack.removeLast() as! Double
        let decimalNumber = firstNumber / 100
        let percentnumber = decimalNumber * currentNumber
        stack.append(firstNumber)
        return percentnumber
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
