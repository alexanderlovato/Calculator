//
//  History+Convenience.swift
//  Calculator2
//
//  Created by Alexander Lovato on 1/18/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import Foundation
import CoreData

extension History {
    convenience init(historyStack: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.historyStack = historyStack
    }
}
