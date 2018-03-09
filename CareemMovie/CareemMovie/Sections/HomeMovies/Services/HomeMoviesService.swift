//
//  HomeMoviesService.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CT_RESTAPI

final class HomeMoviesService {
    
    
    /// <#Description#>
    ///
    /// - Parameter param: <#param description#>
    /// - Returns: <#return value description#>
    class func getMoviesWithParam(param: SearchMovieParams) -> Observable<MovieResults?> {
        
        let apiManager = RESTApiClient(subPath: "search", functionName: "movie", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(param.dictionary)
        
        return apiManager.requestObject(keyPath: nil)
    }
    

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - param: <#param description#>
    ///   - keyPath: <#keyPath description#>
    /// - Returns: <#return value description#>
    class func getMoviesArrayWithParam(param: SearchMovieParams, keyPath: String) -> Observable<[Movie]> {
        
        let apiManager = RESTApiClient(subPath: "search", functionName: "movie", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(param.dictionary)
        
        return apiManager.requestObjects(keyPath: keyPath)
    }
}
