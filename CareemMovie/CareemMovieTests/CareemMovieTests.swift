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
        continueAfterFailure = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
