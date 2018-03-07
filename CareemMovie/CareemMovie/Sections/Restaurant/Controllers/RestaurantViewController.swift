//
//  RestaurantViewController.swift
//  ListingRestaurant
//
//  Created by Canh Tran on 2/27/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxSwift
import RxCocoa

class RestaurantViewController: BaseMainViewController {

    // MARK: Properties
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    fileprivate lazy var loadingView: LoaddingView = {
        let loadingView = LoaddingView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = .clear
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(loadingView)
        return loadingView
    }()
    
    fileprivate let restaurantViewModel = RestaurantListViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(restaurantsTableView, delay: 50.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
 
    // MARK: Setups
    private func setupViews() {
        restaurantsTableView.registerCellNib(RestaurantCell.self)
        restaurantsTableView.rowHeight = UITableViewAutomaticDimension
        restaurantsTableView.estimatedRowHeight = self.view.bounds.width
    }
    
    private func setupViewModel() {
        restaurantViewModel.requestRestaurantsDataSource()
        
        restaurantViewModel.restaurantsDataSource.bind(to: restaurantsTableView.rx.items(cellIdentifier: RestaurantCell.reuseIdentifier)) { (index, model, cell) in
            if let cell = cell as? RestaurantCell {
                cell.setupCellWithModel(model: model, index: index)
            }
            }.disposed(by: disposeBag)
        
        restaurantsTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("Cell item selected at index: \(indexPath.row)")
            }).disposed(by: disposeBag)
    }

}
