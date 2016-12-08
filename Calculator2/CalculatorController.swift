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
    
    // DELETE
    
    // Removes an individual calculator from calculators array
    func removeCalculator(calculator: Calculator) {
        if let calculatorIndex = calculators.index(of: calculator) {
            calculators.remove(at: calculatorIndex)
            saveToPersistentStorage()
        }
    }
    
    // Clears all data from the calculators array
    func clearAllCalculators() {
        calculators.removeAll()
        saveToPersistentStorage()
    }
}
