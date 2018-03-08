//
//  HomeMoviesViewModel.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CT_RESTAPI

final class HomeMoviesViewModel: PaginationNetworkModel<Movie> {
    
    //MARK: - Variables
    fileprivate(set) var moviesResultObservable     : Observable<MovieResults>!
    fileprivate(set) var suggestionsObservable      : Observable<[Suggestion]>!
    fileprivate(set) var searchParam                : Variable<SearchMovieParams>!
    fileprivate(set) var errorObservable            = PublishSubject<CTNetworkErrorType>()
    fileprivate(set) var isLoadingAnimation         = PublishSubject<Bool>()
    fileprivate(set) var queryString                = BehaviorSubject<String>(value: "2018")
    fileprivate(set) var page                       = BehaviorSubject<Int>(value: 1)
    fileprivate      let disposeBag                 = DisposeBag()
    
    func setupHomeMovieViewModel(searchTextField: Reactive<CareemSearchBar>) {
        isLoadingAnimation.onNext(true)
        
        let parameter: Observable<SearchMovieParams> = Observable.combineLatest(queryString.asObservable(), page.asObservable()) { (query, page) ->  SearchMovieParams in
            let param = SearchMovieParams(query: query, page: page)
            self.searchParam = Variable<SearchMovieParams>(param)
            return param
        }
        
        moviesResultObservable = parameter.flatMapLatest { (param) -> Observable<MovieResults?> in
            self.isLoadingAnimation.onNext(true)
            
            return HomeMoviesService.getMoviesWithParam(param: param)
                .observeOn(MainScheduler.instance)
                .catchError({ [weak self] (error) -> Observable<MovieResults?> in
                    self?.errorObservable.onNext(error as! CTNetworkErrorType)
                    return Observable.empty()
                })
            }.map { [weak self] (result) -> MovieResults in
                guard let strongSelf = self, let value = result, value.totaResults > 0  else { return MovieResults() }
                strongSelf.elements.value = value.results
                strongSelf.isLoadingAnimation.onNext(false)
                strongSelf.saveSuggestion(query: strongSelf.searchParam.value.query, totalResult: value.totaResults.description)
                return value
            }.share(replay: 1)
        
        moviesResultObservable
            .subscribe { (_) in
                self.isLoadingAnimation.onNext(false)
            }.disposed(by: disposeBag)
        
        suggestionsObservable = searchTextField.textDidBeginEditing
            .asObservable()
            .flatMapLatest { (_) -> Observable<[Suggestion]> in
                return Observable.just(Suggestion.getListSuggestions())
            }.share(replay: 1)
    }
    
    // Lazy loading method
    override func loadData(offset: Int) -> Observable<[Movie]> {
        self.isLoadingAnimation.onNext(true)
        let observable: Observable<[Movie]> = HomeMoviesService.getMoviesArrayWithParam(param: searchParam.value, keyPath: "results")
            .observeOn(MainScheduler.instance)
            .map { (value) -> [Movie] in
                return value
        }
        observable.subscribe { (_ ) in
            self.isLoadingAnimation.onNext(false)
            }.disposed(by: disposeBag)
        return observable
    }
    
    fileprivate func saveSuggestion(query: String, totalResult: String) {
        let suggestion = Suggestion.createSuggestionObject(name: query, totalResult: totalResult)
        suggestion.saveLatestSuggestion()
    }
    
}
