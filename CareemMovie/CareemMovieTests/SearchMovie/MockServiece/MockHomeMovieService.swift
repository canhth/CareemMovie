//
//  MockHomeMovieService.swift
//  CareemMovieTests
//
//  Created by Tran Hoang Canh on 9/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CT_RESTAPI
@testable import CareemMovie

class MockHomeMoviesService: SearchMovieService {
    
    var isNeedReturnError  = false
    
    /// Get movies with param of Search Movie Service
    ///
    /// - Parameters:
    ///   - param: search param
    ///   - completion: Results and error of API
    /// - Returns: Observable<MovieResults?>
    func getMoviesWithParam(param: SearchMovieParams, completion: @escaping SearchMovieServiceCompletionHandler) -> Observable<MovieResults?> {
        
        if isNeedReturnError {
            let error = RESTError(typeError: .errorMessage(code: 404, status: false, message: "Error of MockHomeMoviesService"))
            completion(nil, error.toError())
            return Observable.just(MovieResults())
        } else {
            var result = MovieResults()
            result.totalPages = 3
            result.totaResults = 50
            
            completion(result, nil)
            return Observable.just(result)
        }
    }
    
    /// Create RESTApiClient
    ///
    /// - Parameter param: object Param
    /// - Returns: MovieResults Observable
    func getMoviesWithParam(param: SearchMovieParams) -> Observable<MovieResults?> {
        
        let apiManager = RESTApiClient(subPath: "search", functionName: "movie", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(param.dictionary)
        
        return apiManager.requestObject(keyPath: nil)
    }
}
