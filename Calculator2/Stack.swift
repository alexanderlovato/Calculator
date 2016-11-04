//
//  Stack.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/11/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation

class Stack {
    
    private var calculationStack = [Double]()
    
    ///Remove the last object from the stack and return it
    func pop() -> Double? {
        return calculationStack.removeLast()
    }
    
    ///Add numbers to the doubleStack
    func push(number: Double) {
        calculationStack.append(number)
    }

    ///Print all number objects to the console
    func log() {
        print(calculationStack)
    }
    
    ///Count everything in the doubleStack
    func count() -> Int {
        return calculationStack.count
    }
    
    ///Clear out all objects from both stacks
    func clearStack() {
        calculationStack.removeAll()
    }
    
    
}
