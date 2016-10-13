//
//  Stack.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/11/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class Stack {
    
    private var doubleStack = [Double]()
    
    func pop() -> Double? {
        return doubleStack.removeLast()
    }
    
    func push(number: Double) {
        doubleStack.append(number)
    }
    
    func log() {
        print(doubleStack)
    }
    
    func count() -> Int {
        return doubleStack.count
    }
    
    func clearStack() {
        doubleStack.removeAll()
    }
    
    
}
