//
//  CalculatorController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation
import CoreData

class CalculatorController {
    
    private let kCalcuators = "calculators"
    private let kHistoryObjects = "historyObjects"
    private let kEverything = "everything"
    
    // MARK: - Shared Instance
    static let sharedController = CalculatorController()
    
    // MARK: Internal Properties
    var calculators: [Calculator] {
        let request: NSFetchRequest<Calculator> = Calculator.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    var history: [History]
    
    init() {
        history = []
    }
    
    // MARK: - Controller Functions
    
    // CREATE
    
    // Appends a new Calculator instance to calculators and saves to UserDefaults
    func saveCalculatorTab(calculatorTab: Calculator) {
        self.saveToPersistentStorage()
    }
    
    func saveHistortyEntry(historyEntry: History) {
        history.append(historyEntry)
        self.saveToHistoryStorage()
    }
    
    // READ
    
    // Loads stored objects from persistent storage
    
    // UPDATE
    
    // Saves all objects in calculators array to persistent storage
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    func saveToHistoryStorage() {
        let historyDictionary = self.history.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(historyDictionary, forKey: kHistoryObjects)
    }
    
    // DELETE
    
    func removeCalculator(historyEntry: History) {
        if let historyIndex = history.index(of: historyEntry) {
            history.remove(at: historyIndex)
            saveToHistoryStorage()
        }
    }
    
    func clearAllHistoryEntires() {
        history.removeAll()
        saveToHistoryStorage()
    }
}
