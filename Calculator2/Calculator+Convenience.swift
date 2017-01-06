//
//  Calculator+Convenience.swift
//  Calculator2
//
//  Created by Alexander Lovato on 1/4/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import Foundation
import CoreData

extension Calculator {
    convenience init(result: String,
                     entireOperationString: String,
                     currentNumber: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.result = result
        self.entireOperationString = entireOperationString
        self.currentNumber = currentNumber
    }
}
