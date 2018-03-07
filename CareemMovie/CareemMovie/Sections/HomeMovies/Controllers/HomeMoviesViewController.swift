//
//  HomeMoviesViewController.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeMoviesViewController: UIViewController {

    //MARK: - IBOutlets & Variables
    
    @IBOutlet weak fileprivate var careemSearchBar: CareemSearchBar!
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    fileprivate var careemSearchController: CareemSearchViewController!
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let homeMoviesViewModel = HomeMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewModel()
    }

    //MARK: - Setup views & ViewModel
    fileprivate func setupViews() {
        careemSearchController = CareemSearchViewController(searchResultsController: self, searchBar: careemSearchBar)
    }
    
    fileprivate func setupViewModel() {
        careemSearchController.customSearchBar.rx.textDidBeginEditing
            .subscribe(onNext: { _ in
                print("didBeginEditing being called")
            }).disposed(by: disposeBag)
        careemSearchController.customSearchBar.rx.textDidEndEditing
            .subscribe(onNext: { _ in
                print("didEndEditing not being called")
            }).disposed(by: disposeBag)
        
        homeMoviesViewModel.setupHomeMovieViewModel()
    }

}

// MARK: CareemSearchControllerDelegate
extension HomeMoviesViewController: CareemSearchControllerDelegate {
    func didTapOnSearchButton() {
        
    }
    
    func didTapOnCancelButton() {
        
    }
}
