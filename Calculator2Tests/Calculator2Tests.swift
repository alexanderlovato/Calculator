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
    
    func testRunOperation() {
        let stack: [Any] = [23, "x", 100, "÷", 3, "+", 1500]
        let answer: Double = 2266
        
        XCTAssertEqual(viewController.runOperation(stackToUse: stack), answer)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
