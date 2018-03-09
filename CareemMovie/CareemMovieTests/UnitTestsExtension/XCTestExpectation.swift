//
//  XCTestExpectation.swift
//  CareemMovieTests
//
//  Created by Tran Hoang Canh on 9/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import XCTest

extension XCTestExpectation {
    private class IntWrapper {
        let value :Int!
        init?(value:Int?) {
            self.value = value
            if (value == nil) {
                return nil
            }
        }
    }
    
    private struct AssociatedKey {
        static var expectationCountKey = ""
    }
    
    
    var expectationCount:Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.expectationCountKey) as? Int
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.expectationCountKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func decrementalFulfill() {
        guard let expectationCount = self.expectationCount else {
            fulfill()
            return
        }
        self.expectationCount = expectationCount - 1
        if self.expectationCount! <= 0 {
            fulfill()
        }
    }
}
