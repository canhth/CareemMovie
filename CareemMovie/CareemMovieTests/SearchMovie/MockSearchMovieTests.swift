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

class MockSearchMovieTests: CareemMovieTests {
    
    var viewModel : HomeMoviesViewModel!
    let disposeBag = DisposeBag()
    
    // Mock serviece
    let mockSearchMovieService = MockHomeMoviesService()
    
    override func setUp() {
        super.setUp()
        viewModel = HomeMoviesViewModel(homeSearchService: mockSearchMovieService)
    }
    
    func testMockResultsWithQuery() {
        var movieMockResult: MovieResults!
        
        viewModel.queryString.onNext("Iron man")
        viewModel.setupHomeMovieViewModel()
        
        viewModel.moviesResultObservable.subscribe(onNext: { (results) in
            guard let results = results else { return }
            movieMockResult = results
        }).disposed(by: disposeBag)
        
        XCTAssertTrue(movieMockResult.totaResults > 0)
    }
}
