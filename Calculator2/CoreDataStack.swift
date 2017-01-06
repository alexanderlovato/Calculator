//
//  CoreDataStack.swift
//  Calculator2
//
//  Created by Alexander Lovato on 1/4/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Calculator2")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
}
