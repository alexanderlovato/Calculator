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
    private let kScreenshotData = "screenshotData"
    
    // MARK: - Internal Properties
    var result: Double?
    var operationStack: [Any]
    var entireOperationString: [String]
    var currentlyTypingNumber: Bool
    var screenshotData: Data?
    var screenshotImage: UIImage? {
        get {
            guard let screenshotData = self.screenshotData else { return nil }
            return UIImage(data: screenshotData)
        } set {
            guard let newValue = newValue, let data = UIImagePNGRepresentation(newValue) else { return }
            screenshotData = data
        }
    }
    
    // MARK: - Initializers
    init(result: Double = 0, operationStack: [Any] = [], entireOperationString: [String] = [], currentlyTypingNumber: Bool = false, screenshotData: Data? = Data()) {
        self.result = result
        self.operationStack = operationStack
        self.entireOperationString = entireOperationString
        self.currentlyTypingNumber = currentlyTypingNumber
        self.screenshotData = screenshotData
    }
    
    init?(dictionary: [String : Any]) {
        guard let result = dictionary[kResult] as? Double,
            let operationStack = dictionary[kOperationStack] as? [Any],
            let entireOperationString = dictionary[kEntireOperationString] as? [String],
            let currentlyTypingNumber = dictionary[kCurrentlyTypingNumber] as? Bool,
            let screenshotData = dictionary[kScreenshotData] as? Data else {
                self.result = 0
                self.operationStack = []
                self.entireOperationString = []
                self.currentlyTypingNumber = false
                self.screenshotData = Data()
                return nil
        }
        
        self.result = result
        self.operationStack = operationStack
        self.entireOperationString = entireOperationString
        self.currentlyTypingNumber = currentlyTypingNumber
        self.screenshotData = screenshotData
    }
    
    // MARK: - Model Functions
    
    // Converts all model objects to a [String : Any] dictionary
    func dictionaryCopy() -> [String : Any] {
        let dictionary: [String : Any] = [
            kResult : self.result!,
            kOperationStack : self.operationStack,
            kEntireOperationString: self.entireOperationString,
            kCurrentlyTypingNumber : self.currentlyTypingNumber,
            kScreenshotData : self.screenshotData!
        ]
        return dictionary
    }
    
    // Appends number or operator to operationStack
    func enter(addToStack: Any) {
        operationStack.append(addToStack)
        print(operationStack)
    }
    
    // Appends number or operator to entireOperationString
    func pushToStringStack(addToStack: String) {
        entireOperationString.append(addToStack)
    }
    
    // Merges a stack of numbers and operators from History to operationStack (TBD)
    func mergeStacks(addToStack: [Any]) {
        operationStack += addToStack
        print(operationStack)
    }
    
    // Remvoes all data from operation stack
    func delete() {
        operationStack.removeAll()
        print(operationStack)
    }
}

// MARK: - Equatable Protocol Function
func ==(lhs: Calculator, rhs: Calculator) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}




