//
//  SearchMovieTests.swift
//  CareemMovieTests
//
//  Created by Tran Hoang Canh on 9/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import XCTest
import RxSwift
@testable import CareemMovie

class SearchMovieTests: CareemMovieTests {
    
    // MARK: properties
    var viewModel : HomeMoviesViewModel!
    let disposeBag = DisposeBag()
    
    let searchMovieService = HomeMoviesService()
    
    override func setUp() {
        super.setUp()
        viewModel = HomeMoviesViewModel(homeSearchService: searchMovieService)
    }
    
    //MARK: Test cases
    func testRealResultsWithQuery() {
        
        let expectation =  self.expectation(description: "SomeService does stuff and runs the callback closure")
        
        viewModel.queryString.onNext("Iron man")
        viewModel.setupHomeMovieViewModel()
        viewModel.moviesResultObservable.subscribe(onNext: { (results) in
            print(results)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: timeOut) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
