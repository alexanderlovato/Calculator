//
//  Calculator2Tests.swift
//  Calculator2Tests
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import XCTest
@testable import Calculator2

class Calculator2Tests: XCTestCase {
    
    let viewController = CalculatorViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRunOperation() {
        let stack: [Any] = [23, "x", 100, "÷", 3, "+", 1500]
        let answer: Double = 2266
        
        XCTAssertEqual(viewController.runOperation(stackToUse: stack), answer)
    }
    
    func testConvertToDecimalNumber() {
        let numberString = "5000"
        let answer = "5000."
        viewController.loadViewIfNeeded()
        viewController.calculator.currentlyTypingNumber = true
        let returnedValue = viewController.convertToDecimalNumber(number: numberString)
        print(returnedValue)
        XCTAssertTrue(returnedValue == answer)
        
    }
    
    func testPositiveOrNegative() {
        let number: Double = 10
        let answer = "-10"
        
        XCTAssertTrue(viewController.positiveOrNegative(currentNumber: number) == answer)
    }
    
    func testRemoveTrailingZero() {
        let number: Double = 35.0
        let answer1 = "35"
        
        XCTAssertTrue(viewController.removeTrailingZero(number: number) == answer1)
    }
    
    func testPercentage() {
        let number: Double = 20
        viewController.calculator.operationStack = [20, "x", 150, "-"]
        let answer: Double = 600
        
        XCTAssertEqual(viewController.percentage(currentNumber: number), answer)
        
        
    }
    
}














