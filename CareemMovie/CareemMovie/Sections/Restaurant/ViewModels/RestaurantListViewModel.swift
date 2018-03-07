//
//  RestaurantListViewModel.swift
//  ListingRestaurant
//
//  Created by Tran Hoang Canh on 28/2/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxSwift
import CocoaLumberjack

class RestaurantListViewModel {

    // MARK: Private properties
    private let disposeBag = DisposeBag()
    
    fileprivate(set) var restaurantsDataSource: Observable<[Restaurant]>!
    
    func requestRestaurantsDataSource() {
        if let jsonData = Helper.getDataFromJSONFile(fileName: "restaurants", key: "restaurants") {
            do {
                let result = try JSONDecoder().decode([Restaurant].self, from: jsonData)
                restaurantsDataSource = Observable<[Restaurant]>.just(result)
            } catch {
                DDLogInfo("Error when parsing JSON: \(error)")
            }
        }
    }
    
}
