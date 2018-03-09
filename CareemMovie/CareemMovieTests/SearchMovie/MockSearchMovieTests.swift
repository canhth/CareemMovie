//
//  MockSearchMovieTests.swift
//  CareemMovieTests
//
//  Created by Tran Hoang Canh on 9/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import CareemMovie

/* TEST CASES:
 1. Mock test search success
 2. Mock test search with error
 */

extension SearchMovieTests {
    
    // Mock serviece
    
    func testMockResultsWithSuccess() {

        viewModel = HomeMoviesViewModel(homeSearchService: MockHomeMoviesService())

        var movieMockResult: MovieResults!

        viewModel.queryString.onNext("Iron man")
        viewModel.setupHomeMovieViewModel()

        viewModel.moviesResultObservable.subscribe(onNext: { (results) in
            guard let results = results else { return }
            movieMockResult = results
            print("\n\nSearchMovieTests - Found results \(results.totaResults)\n\n")
        }).disposed(by: disposeBag)

        XCTAssertTrue(movieMockResult.totaResults > 0)
    }
    
    func testMockResultsWithError() {
        let mockHomeMovieService = MockHomeMoviesService()
        
        mockHomeMovieService.isNeedReturnError = true
        viewModel = HomeMoviesViewModel(homeSearchService: mockHomeMovieService)
        
        var mockError: Error!
        viewModel.setupHomeMovieViewModel()
        viewModel.queryString.onNext("Iron man")
        
        viewModel.errorObservable.asObserver().subscribe(onNext: { (error) in
            mockError = error
            print("Mock results with error: \(error)")
        }).disposed(by: disposeBag)
        
        viewModel.moviesResultObservable.subscribe { (_) in
        }.disposed(by: disposeBag)
        
        XCTAssertTrue(mockError != nil)
    }
}
