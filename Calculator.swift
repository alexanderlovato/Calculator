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
    private let kCurrentlyTypingNumber = "currentlyTypingNumber"
    
    // MARK: - Internal Properties
    var result: Double?
    var operationStack: [Any]
    var currentlyTypingNumber: Bool
    
    // MARK: - Initializers
    init(result: Double = 0, operationStack: [Any] = [], currentlyTypingNumber: Bool = false) {
        self.result = result
        self.operationStack = operationStack
        self.currentlyTypingNumber = currentlyTypingNumber
    }
    
    init?(dictionary: [String : Any]) {
        guard let result = dictionary[kResult] as? Double,
        let operationStack = dictionary[kOperationStack] as? [Any],
            let currentlyTypingNumber = dictionary[kCurrentlyTypingNumber] as? Bool else {
                self.result = 0
                self.operationStack = []
                self.currentlyTypingNumber = false
                return nil
        }
        
        self.result = result
        self.operationStack = operationStack
        self.currentlyTypingNumber = currentlyTypingNumber
    }
    
    func dictionaryCopy() -> [String : Any] {
        let dictionary: [String : Any] = [
            kResult : self.result!,
            kOperationStack : self.operationStack,
            kCurrentlyTypingNumber : self.currentlyTypingNumber]
        return dictionary
    }
}

func ==(lhs: Calculator, rhs: Calculator) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}





