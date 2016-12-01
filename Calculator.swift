//
//  Calculator.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation
import UIKit

class Calculator: Equatable {
    
    // MARK: - Private Properties
    
    private let kResult = "result"
    private let kOperationStack = "operationStack"
    private let kEntireOperationString = "entireOperationString"
    private let kCurrentlyTypingNumber = "currentlyTypingNumber"
    private let kCalculatorScreenShot = "calculatorScreenShot"
    
    // MARK: - Internal Properties
    var result: Double?
    var operationStack: [Any]
    var entireOperationString: [String]
    var currentlyTypingNumber: Bool
    var calculatorScreenShot: UIView?
    
    // MARK: - Initializers
    init(result: Double = 0, operationStack: [Any] = [], entireOperationString: [String] = [], currentlyTypingNumber: Bool = false, calculatorScreenShot: UIView = UIView.init()) {
        self.result = result
        self.operationStack = operationStack
        self.entireOperationString = entireOperationString
        self.currentlyTypingNumber = currentlyTypingNumber
        self.calculatorScreenShot = calculatorScreenShot
    }
    
    init?(dictionary: [String : Any]) {
        guard let result = dictionary[kResult] as? Double,
        let operationStack = dictionary[kOperationStack] as? [Any],
            let entireOperationString = dictionary[kEntireOperationString] as? [String],
                let currentlyTypingNumber = dictionary[kCurrentlyTypingNumber] as? Bool,
                    let calculatorScreenShot = dictionary[kCalculatorScreenShot] as? UIView else {
                self.result = 0
                self.operationStack = []
                self.entireOperationString = []
                self.currentlyTypingNumber = false
                self.calculatorScreenShot = UIView.init()
                return nil
        }
        
        self.result = result
        self.operationStack = operationStack
        self.entireOperationString = entireOperationString
        self.currentlyTypingNumber = currentlyTypingNumber
        self.calculatorScreenShot = calculatorScreenShot
    }
    
    func dictionaryCopy() -> [String : Any] {
        let dictionary: [String : Any] = [
            kResult : self.result!,
            kOperationStack : self.operationStack,
            kEntireOperationString: self.entireOperationString,
            kCurrentlyTypingNumber : self.currentlyTypingNumber,
            kCalculatorScreenShot : self.calculatorScreenShot!]
        return dictionary
    }
}

func ==(lhs: Calculator, rhs: Calculator) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}





