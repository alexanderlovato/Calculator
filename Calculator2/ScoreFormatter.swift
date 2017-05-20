//
//  ScoreFormatter.swift
//  Pointedly
//
//  Created by Ben Norris on 12/7/15.
//  Copyright © 2015 BSN Design. All rights reserved.
//

import Foundation

struct ScoreFormatter {
    
    static fileprivate var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    static fileprivate var noFormatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
    
    static func formattedScore(_ score: NSNumber?) -> String? {
        return formattedScore(score?.intValue)
    }
    
    static func formattedScore(_ score: Int?) -> String? {
        guard let score = score else { return nil }
        let formattedScore = numberFormatter.string(from: NSNumber(integerLiteral: score))
        return formattedScore
    }
    
    static func formattedScore(_ scoreString: String?) -> String? {
        guard let scoreString = scoreString, let score = numberFormatter.number(from: scoreString) else { return nil }
        // Removed the numberFormatter call and just set formatterScore to be a String
        let formattedScore = "\(score)"
        return formattedScore
    }
    
    static func unformattedNumberString(_ number: NSNumber?) -> String? {
        return unformattedNumberString(number?.intValue)
    }
    
    static func unformattedNumberString(_ number: Int?) -> String? {
        guard let number = number else { return nil }
        let unformattedNumber = noFormatFormatter.string(from: NSNumber(integerLiteral: number))
        return unformattedNumber
    }
    
    static func unformattedNumberString(_ numberString: String?) -> String? {
        guard let numberString = numberString, let number = numberFormatter.number(from: numberString) else { return nil }
        let unformattedNumber = noFormatFormatter.string(from: number)
        return unformattedNumber
    }
    
    static func unformattedNumber(_ numberString: String?) -> NSNumber? {
        guard let numberString = numberString else { return nil }
        let number = numberFormatter.number(from: numberString)
        return number
    }
    
}
