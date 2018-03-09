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

/* TEST CASES:
 1. Test search with keyword 'Iron man'
 2. Test search with next page
 */

class SearchMovieTests: CareemMovieTests {
    
    // MARK: properties
    var viewModel : HomeMoviesViewModel!
    let disposeBag = DisposeBag()
    
    let searchMovieService = HomeMoviesService()
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: Base functions
    func getResultSuccessWithQuery(query: String, page: Int? = nil) -> MovieResults {
        viewModel = HomeMoviesViewModel(homeSearchService: searchMovieService)
        
        var movieResults: MovieResults!
        
        // The expectation to wait until got the response from API
        let expectation =  self.expectation(description: "SomeService does stuff and runs the callback closure")
        
        viewModel.setupHomeMovieViewModel()
        if let page = page {
            viewModel.page.onNext(page)
        }
        viewModel.queryString.onNext(query)
        
        viewModel.moviesResultObservable.subscribe(onNext: { (results) in
            guard let results = results else { return }
            movieResults = results
            print("\n\nSearchMovieTests - Found results \(results.totaResults)\n\n")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: timeOut) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        return movieResults
    }
    
    // MARK: Test cases
    func testGetResultsSuccessWithQueryIronMan() {
        
        let movieResults: MovieResults = getResultSuccessWithQuery(query: "Iron man")
        XCTAssertTrue(movieResults.totaResults > 0)
    }
    
    func testGetResultsSuccessWithNextPageIronMan() {
        let movieResults: MovieResults = getResultSuccessWithQuery(query: "Iron man", page: 2)
        
        XCTAssertTrue(movieResults.totaResults > 0)
    }
}
