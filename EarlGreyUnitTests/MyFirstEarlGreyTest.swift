//
//  MyFirstEarlGreyTest.swift
//  Calculator2
//
//  Created by Alexander Lovato on 4/24/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Calculator2

class MyFirstEarlGreyTest: XCTestCase {
    
    // MARK: - Operator Matchers
    let saveResultMatcher = grey_accessibilityLabel("SaveResultLabel")
    let clearMatcher = grey_accessibilityLabel("ClearLabel")
    let plusMinusMatcher = grey_accessibilityLabel("PlusMinusLabel")
    let percentageMatcher = grey_accessibilityLabel("PercentageLabel")
    let divideMatcher = grey_accessibilityLabel("DivideLabel")
    let multiplicationMatcher = grey_accessibilityLabel("MultiplicationLabel")
    let SubtractionMatcher = grey_accessibilityLabel("SubtractionLabel")
    let additionMatcher = grey_accessibilityLabel("AdditionLabel")
    let equalMatcher = grey_accessibilityLabel("EqualMatcher")
    
    // MARK: - Numberpad Matchers
    let zeroMatcher = grey_accessibilityLabel("ZeroLabel")
    let oneMatcher = grey_accessibilityLabel("OneLabel")
    let twoMatcher = grey_accessibilityLabel("TwoLabel")
    let threeMatcher = grey_accessibilityLabel("ThreeLabel")
    let fourMatcher = grey_accessibilityLabel("FourLabel")
    let fiveMatcher = grey_accessibilityLabel("FiveLabel")
    let sixMatcher = grey_accessibilityLabel("SixLabel")
    let sevenMatcher = grey_accessibilityLabel("SevenLabel")
    let eightMatcher = grey_accessibilityLabel("EightLabel")
    let nineMatcher = grey_accessibilityLabel("NineLabel")
    let decimalMatcher = grey_accessibilityLabel("DecimalLabel")
    
    // MARK: - Other UI Elements
    let resultLabelMatcher = grey_accessibilityLabel("ResultLabel")
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        EarlGrey.select(elementWithMatcher: grey_keyWindow())
        .assert(grey_sufficientlyVisible())
    }
    
    func testPercentageSelection() {
        grey_kindOfClass(ButtonFontSize.self)
        let button5 = EarlGrey.select(elementWithMatcher: fiveMatcher)
        button5.perform(grey_tap())
        let multiply = EarlGrey.select(elementWithMatcher: multiplicationMatcher)
        multiply.perform(grey_tap())
        let button9 = EarlGrey.select(elementWithMatcher: nineMatcher)
        button9.perform(grey_tap())
        let minus = EarlGrey.select(elementWithMatcher: SubtractionMatcher)
        minus.perform(grey_tap())
        button5.perform(grey_tap())
        let buttonTapped = EarlGrey.select(elementWithMatcher: percentageMatcher)
        buttonTapped.perform(grey_tap())
        let equals = EarlGrey.select(elementWithMatcher: equalMatcher)
        equals.perform(grey_tap())
        let resultLabel = EarlGrey.select(elementWithMatcher: resultLabelMatcher)
        resultLabel.assert(grey_text("42.75"))
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
