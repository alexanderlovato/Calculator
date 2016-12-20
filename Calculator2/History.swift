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
    
    // MARK: - Internal Properties
    var histroyArray: [Any]
    
    // MARK: - Initializers
    init(histroyArray: [Any] = []) {
        self.histroyArray = histroyArray
    }
    
    init?(dictionary: [String : Any]) {
        guard let histroyArray = dictionary[kHistoryArray] as? [Any] else {
            self.histroyArray = []
            return nil
        }
        self.histroyArray = histroyArray
    }
    
    func dictionaryCopy() -> [String : Any] {
        let dictionary: [String : Any] = [
            kHistoryArray : self.histroyArray]
        return dictionary
    }
}

func ==(lhs: History, rhs: History) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
