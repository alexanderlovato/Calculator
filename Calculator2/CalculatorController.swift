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
    private let kHistoryObjects = "historyObjects"
    private let kEverything = "everything"
    
    // MARK: - Shared Instance
    static let sharedController = CalculatorController()
    
    // MARK: Internal Properties
    var calculators: [Calculator]
    var history: [History]
    
    init() {
        calculators = []
        history = []
        self.loadFromPersistentStorage()
    }
    
    // MARK: - Controller Functions
    
    // CREATE
    
    // Appends a new Calculator instance to calculators and saves to UserDefaults
    func saveCalculatorTab(calculatorTab: Calculator) {
        calculators.append(calculatorTab)
        self.saveToPersistentStorage()
    }
    
    func saveHistortyEntry(historyEntry: History) {
        history.append(historyEntry)
        self.saveToHistoryStorage()
    }
    
    // READ
    
    // Loads stored objects from persistent storage
    func loadFromPersistentStorage() {
        
        guard let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kEverything) as?[[String : Any]] else {return}
        self.calculators = calculatorDictionariesFromDefaults.map({Calculator(dictionary: $0)!})
        self.history = calculatorDictionariesFromDefaults.map({History(dictionary: $0)!})
    }
    
    // UPDATE
    
    // Saves all objects in calculators array to persistent storage
    func saveToPersistentStorage() {
        
        let historyDictionary = self.history.map({$0.dictionaryCopy()})
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        let combinedDictionary: [String : Any] = [kCalcuators : calculatorDictionaries, kHistoryObjects : historyDictionary]
        UserDefaults.standard.set(combinedDictionary, forKey: kEverything)
    }
    
    func saveToHistoryStorage() {
        let historyDictionary = self.history.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(historyDictionary, forKey: kHistoryObjects)
    }
    
    // DELETE
    
    func removeCalculator(historyEntry: History) {
        if let historyIndex = history.index(of: historyEntry) {
            calculators.remove(at: historyIndex)
            saveToHistoryStorage()
        }
    }
    
    func clearAllHistoryEntires() {
        history.removeAll()
        saveToHistoryStorage()
    }
}
