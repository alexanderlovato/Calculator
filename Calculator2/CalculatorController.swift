//
//  CalculatorController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class CalculatorController {
    
    private let kCalcuators = "calculators"
    
    // MARK: - Shared Instance
    static let sharedController = CalculatorController()
    
    // MARK: - Class Instances
    var calculator = Calculator()
    
    // MARK: Internal Properties
    var calculators: [Calculator]
    
    init() {
        calculators = []
        
        self.loadFromPersistentStorage()
    }
    
    // MARK: - Computed Properties
    var currentlyTypingNumber: Bool {
        get {
            return calculator.currentlyTypingNumber
        } set {
            calculator.currentlyTypingNumber = newValue
        }
    }
    
    // MARK: - Controller Functions
    
    // CREATE
    func saveCalculatorTab(calculatorTab: Calculator) {
        calculators.append(calculatorTab)
        
        self.saveToPersistentStorage()
    }
    
    // READ
    
    func loadFromPersistentStorage() {
        let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kCalcuators) as? [Dictionary<String, AnyObject>]
        
        if let calculatorDictionaries = calculatorDictionariesFromDefaults {
            self.calculators = calculatorDictionaries.map({Calculator(dictionary: $0)!})
        }
    }
    
    
    // UPDATE
    
    func saveToPersistentStorage() {
        
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(calculatorDictionaries, forKey: kCalcuators)
    }
    
    ///Calculates a stack of Doubles and operator Strings with operator precedence.
    func runOperation(stackToUse: [Any]) -> Double {
        
        var operationStack = stackToUse
        for _ in operationStack {
            for (index, item) in operationStack.enumerated() {
                guard let item = item as? String else { continue }
                if item == "*" {
                    let first = operationStack[index - 1] as! Double
                    let second = operationStack[index + 1] as! Double
                    operationStack[index - 1] = first * second
                    operationStack.remove(at: index)
                    operationStack.remove(at: index)
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
        
        var stack = calculator.operationStack
        
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
        calculator.operationStack.append(addToStack)
        print(calculator.operationStack)
    }
    
    // DELETE
    
    ///Delete all objects from the stack
    func delete() {
        calculator.operationStack.removeAll()
        print(calculator.operationStack)
        calculator.result = 0
    }
    
    func removeCalculator(calculator: Calculator) {
        if let calculatorIndex = calculators.index(of: calculator) {
            calculators.remove(at: calculatorIndex)
            saveToPersistentStorage()
        }
    }
    
    func deleteCalculatorTab(calculatorTab: Calculator) {
        if let calculatorIndex = calculators.index(of: calculatorTab) {
            calculators.remove(at: calculatorIndex)
        }
    }
    
}
