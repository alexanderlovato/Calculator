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
        
    // MARK: Internal Properties
    var calculators: [Calculator]
    
    // MARK: - Initializers
    init() {
        calculators = []
        self.loadFromPersistentStorage()
    }
    
    // MARK: - Controller Functions
    
    // CREATE
    
    // Appends a new Calculator instance to calculators and saves to UserDefaults
    func saveCalculatorTab(calculatorTab: Calculator) {
        calculators.append(calculatorTab)
        self.saveToPersistentStorage()
    }
    
    // READ
    
    // Loads stored objects from persistent storage
    func loadFromPersistentStorage() {
        guard let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kCalcuators) as? [[String : Any]] else {return}
        self.calculators = calculatorDictionariesFromDefaults.map({Calculator(dictionary: $0)!})
    }
    
    // UPDATE
    
    // Saves all objects in calculators array to persistent storage
    func saveToPersistentStorage() {
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(calculatorDictionaries, forKey: kCalcuators)
    }
    
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
