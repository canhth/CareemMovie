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

final class HomeMoviesViewModel {
    
    //MARK: - Variables
    fileprivate let disposeBag = DisposeBag()
    
    func setupHomeMovieViewModel() {
        
        HomeMoviesService.getMoviesWithQuery(query: "2018", page: 1)
            .subscribe(onNext: { [weak self] (results) in
                print("Results")
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
        
    }
    
    
}
