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
    
    ///Remove the last object from the stack and return it
    func pop() -> Double? {
        return doubleStack.removeLast()
    }
    
    ///Add numbers to the stack
    func push(number: Double) {
        doubleStack.append(number)
    }
    
    ///Print all number objects to the console
    func log() {
        print(doubleStack)
    }
    
    ///Count everything in the stack
    func count() -> Int {
        return doubleStack.count
    }
    
    ///Clear out all objects from the stack
    func clearStack() {
        doubleStack.removeAll()
    }
    
    
}
