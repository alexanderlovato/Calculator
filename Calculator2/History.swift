//
//  History.swift
//  Calculator2
//
//  Created by Alexander Lovato on 12/18/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import Foundation
import UIKit

class History: Equatable {
    
    // MARK: - Private Properties
    private let kHistoryArray = "historyArray"
    private let kCalculators = "calculators"
    
    // MARK: - Internal Properties
    var histroyArray: [String]
    var calculators: [Calculator]
    
    // MARK: - Initializers
    init(histroyArray: [String] = [], calculators: [Calculator] = []) {
        self.histroyArray = histroyArray
        self.calculators = calculators
    }
    
    init?(dictionary: [String : Any]) {
        guard let histroyArray = dictionary[kHistoryArray] as? [String],
        let calculators = dictionary[kCalculators] as? [Calculator] else {
            self.histroyArray = []
            self.calculators = []
            return nil
        }
        self.histroyArray = histroyArray
        self.calculators = calculators
    }
    
    func dictionaryCopy() -> [String : Any] {
        let dictionary: [String : Any] = [
            kHistoryArray : self.histroyArray,
            kCalculators : self.calculators]
        return dictionary
    }
}

func ==(lhs: History, rhs: History) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
