//
//  FunWithDiceTests.swift
//  FunWithDiceTests
//
//  Created by Ellen Widerski on 2/18/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import XCTest
@testable import FunWithDice

class FunWithDiceTests: XCTestCase {
    var myCup: Cup
    
    override init() {
        myCup = Cup(numDice: 5, numSides: 6)
        super.init()
    }
    
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
        
        myCup.shake()
        XCTAssertEqual(myCup[0].value,2)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
