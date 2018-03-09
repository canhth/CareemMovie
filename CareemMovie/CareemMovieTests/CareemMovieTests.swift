//
//  CareemMovieTests.swift
//  CareemMovieTests
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import XCTest
@testable import CareemMovie

class CareemMovieTests: XCTestCase {
    
    let finished = NSPredicate(format: "value == 1")
    let timeOut: TimeInterval = 10
    
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
    
    func waitUntilRequestSuccess() -> XCTestExpectation {
        let expectation =  self.expectation(description: "SomeService does stuff and runs the callback closure")
        self.waitForExpectations(timeout: timeOut) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        return expectation
    }
    
}
