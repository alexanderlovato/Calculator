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
    
    // MARK: - Shared Instance
    static let sharedController = CalculatorController()
    
    // MARK: Internal Properties
    var calculators: [Calculator]
    
    var history: [History] {
        let request: NSFetchRequest<History> = History.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    init() {
        calculators = []
        self.loadFromUserDefaults()
    }
    
    // MARK: - Controller Functions
    
    // CREATE
    
    // Appends a new Calculator instance to calculators and saves to UserDefaults
    func saveCalculatorTab(calculatorTab: Calculator) {
        calculators.append(calculatorTab)
        self.saveToPersistentStorage()
    }
    
    // Saves History entry in Core Data
    func saveHistortyEntry(historyEntry: History) {
        self.saveToHistoryStorage()
    }
    
    // READ
    
    // Loads stored objects from persistent storage
    func loadFromUserDefaults() {
        guard let calculatorDictionariesFromDefaults = UserDefaults.standard.object(forKey: kCalcuators) as? [[String : Any]] else { return }
        self.calculators = calculatorDictionariesFromDefaults.map({Calculator(dictionary: $0)!})
    }
    
    // UPDATE
    
    // Saves all objects in calculators array to persistent storage
    func saveToPersistentStorage() {
        let calculatorDictionaries = self.calculators.map({$0.dictionaryCopy()})
        UserDefaults.standard.set(calculatorDictionaries, forKey: kCalcuators)
    }
    
    // Saves Managed Object Context in the persistent store
    func saveToHistoryStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    // DELETE
    
    func removeCalculator(historyEntry: History) {
        historyEntry.managedObjectContext?.delete(historyEntry)
            saveToHistoryStorage()
    }
    
    func clearAllHistoryEntires() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try CoreDataStack.context.execute(request)
        } catch {
            NSLog("Error deleting data from entity: \(error)")
        }
        saveToHistoryStorage()
    }
}
