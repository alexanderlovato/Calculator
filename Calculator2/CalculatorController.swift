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
    
    // MARK: - Shared Instance
    static let sharedController = CalculatorController()
    
    // MARK: Internal Properties
    var calculators: [Calculator]
    var historyObjects: [History]
    
    init() {
        calculators = []
        historyObjects = []
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
        historyObjects.append(historyEntry)
        self.saveToHistoryStorage()
    }
    
    // READ
    
    // Loads stored objects from persistent storage
    func loadFromPersistentStorage() {
        guard let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kCalcuators) as?[[String : Any]],
        let historyDictionariesFromDefaults = UserDefaults.standard.object(forKey: kHistoryObjects) as?[[String : Any]] else {return}
        self.calculators = calculatorDictionariesFromDefaults.map({Calculator(dictionary: $0)!})
        self.historyObjects = historyDictionariesFromDefaults.map({History(dictionary: $0)!})
    }
    
    // UPDATE
    
    // Saves all objects in calculators array to persistent storage
    func saveToPersistentStorage() {
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(calculatorDictionaries, forKey: kCalcuators)
    }
    
    func saveToHistoryStorage() {
        let historyDictionary = self.historyObjects.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(historyDictionary, forKey: kHistoryObjects)
    }
    
    // DELETE
    
    func removeCalculator(historyEntry: History) {
        if let historyIndex = historyObjects.index(of: historyEntry) {
            calculators.remove(at: historyIndex)
            saveToHistoryStorage()
        }
    }
    
    func clearAllHistoryEntires() {
        historyObjects.removeAll()
        saveToHistoryStorage()
    }
}
