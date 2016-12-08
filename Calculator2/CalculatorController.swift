//
//  CalculatorController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation
import UIKit

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
//    var currentlyTypingNumber: Bool {
//        get {
//            
//            return calculator.currentlyTypingNumber
//        } set {
//            calculator.currentlyTypingNumber = newValue
//        }
//    }
    
    // MARK: - Controller Functions
    
    // CREATE
    func saveCalculatorTab(calculatorTab: Calculator) {
        calculators.append(calculatorTab)
        
        self.saveToPersistentStorage()
    }
    
    //MARK: - UserDefaults functions
    // READ
    func loadFromPersistentStorage() {
        guard let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kCalcuators) as? [[String : Any]] else {return}
        self.calculators = calculatorDictionariesFromDefaults.map({Calculator(dictionary: $0)!})
    }
    
    // UPDATE
    func saveToPersistentStorage() {
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(calculatorDictionaries, forKey: kCalcuators)
    }
    
    
    //MARK: - Class Methods
    ///Calculates a stack of Doubles and operator Strings with operator precedence.
    func runOperation(stackToUse: [Any]) -> Double {
                
        let operationStack = stackToUse
        var operationString = operationStack.map{ String(describing: $0) }.joined(separator: " ")
        operationString = operationString.replacingOccurrences(of: "÷", with: "/")
        operationString = operationString.replacingOccurrences(of: "x", with: "*")
        let expression = NSExpression(format: operationString, argumentArray: [])
        let value = expression.expressionValue(with: nil, context: nil) as! NSNumber
        return value.doubleValue
        
        //Former logic for this function. 
        //Haven't deleted it yet because not sure if this logic will become useful later
//        for _ in operationStack {
//            for (index, item) in operationStack.enumerated() {
//                guard let item = item as? String else { continue }
//                if item == "x" {
//                    let first = operationStack[index - 1] as! Double
//                    let second = operationStack[index + 1] as! Double
//                    operationStack[index - 1] = first * second
//                    operationStack.remove(at: index)
//                    operationStack.remove(at: index)
//                    break
//                } else if item == "÷" {
//                    let first = operationStack[index - 1] as! Double
//                    let second = operationStack[index + 1] as! Double
//                    operationStack[index - 1] = first / second
//                    operationStack.remove(at: index)
//                    operationStack.remove(at: index)
//                    break
//                }
//            }
//        }
//        
//        for _ in operationStack {
//            for (index, item) in operationStack.enumerated() {
//                guard let item = item as? String else { continue }
//                if item == "+" {
//                    let first = operationStack[index - 1] as! Double
//                    let second = operationStack[index + 1] as! Double
//                    operationStack[index - 1] = first + second
//                    operationStack.remove(at: index)
//                    operationStack.remove(at: index)
//                    break
//                } else if item == "-" {
//                    let first = operationStack[index - 1] as! Double
//                    let second = operationStack[index + 1] as! Double
//                    operationStack[index - 1] = first - second
//                    operationStack.remove(at: index)
//                    operationStack.remove(at: index)
//                    break
//                }
//            }
//        }
//        let returnNumber = operationStack.removeLast() as! Double
//        return value
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
        } else if stack.count == 0 {
            let decimalNumber = currentNumber / 100
            return decimalNumber
        } else {
            let _ = stack.removeLast()
            let firstNumber = stack.last as! Double
            let decimalNumber = firstNumber / 100
            let percentnumber = decimalNumber * currentNumber
            return percentnumber
        }
    }
    
    // DELETE
    func removeCalculator(calculator: Calculator) {
        if let calculatorIndex = calculators.index(of: calculator) {
            calculators.remove(at: calculatorIndex)
            saveToPersistentStorage()
        }
    }
    
    func clearAllCalculators() {
        calculators.removeAll()
        saveToPersistentStorage()
    }
    
    func deleteCalculatorTab(calculatorTab: Calculator) {
        if let calculatorIndex = calculators.index(of: calculatorTab) {
            calculators.remove(at: calculatorIndex)
        }
    }
    
}
