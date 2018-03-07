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
    
    class func getMoviesWithQuery(query: String, page: Int) -> Observable<MovieResults?> {
        
        let apiManager = RESTApiClient(subPath: "search", functionName: "movie", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(SearchMovieParams(query: query, page: page).dictionary)
        
        return apiManager.requestObject(keyPath: nil)
    }
}
