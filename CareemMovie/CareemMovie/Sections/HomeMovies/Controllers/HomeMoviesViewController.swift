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

final class HomeMoviesViewController: BaseMainViewController {

    //MARK: - IBOutlets & Variables
    @IBOutlet weak fileprivate var tableView: UITableView!
    @IBOutlet weak fileprivate var tableHeaderView: UIView!
    @IBOutlet weak fileprivate var careemSearchBar: CareemSearchBar!
    @IBOutlet weak fileprivate var resultsLabel: UILabel!
    @IBOutlet weak fileprivate var containerView: UIView!
    
    fileprivate var careemSearchController: CareemSearchViewController!
    fileprivate let disposeBag = DisposeBag()
    fileprivate let homeMoviesViewModel = HomeMoviesViewModel()
    
    fileprivate lazy var loadingView: LoaddingView = {
        let loadingView = LoaddingView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = .clear
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(loadingView)
        return loadingView
    }()
    
    fileprivate lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let attributes = [ NSAttributedStringKey.foregroundColor : UIColor.careemTextColor ] as [NSAttributedStringKey: Any]
        refreshControl.tintColor = UIColor.careemOrangeColor
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading...", attributes: attributes)
        return refreshControl
    }()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewModel()
        setupSearchSuggestionController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.setupHeightHeaderTableViewAutomaticly()
    }

    //MARK: - Setup views & ViewModel
    fileprivate func setupViews() {
        
        careemSearchController = CareemSearchViewController(searchResultsController: self, searchBar: careemSearchBar)
        setupSuggestionsList(forBeginSearch: false)
        
        // TableView
        tableView.registerCellNib(MovieCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = self.view.bounds.width
        
        // RefreshControl
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: self.homeMoviesViewModel.refreshTrigger)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)       // User pulled down to refresh
            .map { _ in self.refreshControl.isRefreshing }
            .filter { $0 == true }
            .subscribe(onNext: { [unowned self] _ in
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        // For Lazy paging loading
        tableView.rx
            .contentOffset
            .flatMap { offset in
                self.tableView.isNearTheBottomEdge(contentOffset: offset, startLoadingOffset: 50) ? Observable.of() : Observable.empty()
            }
            .bind(to: homeMoviesViewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupSearchSuggestionController() {
        if let suggestionsViewController = self.childViewControllers.first as? SearchSuggestionsViewController {
            suggestionsViewController.homeMoviesViewModel = self.homeMoviesViewModel
            suggestionsViewController.setupSuggestionViewModel()
        }
    }
    
    fileprivate func setupViewModel() {
        homeMoviesViewModel.setupHomeMovieViewModel(searchTextField: careemSearchBar.rx)
        
        // For list suggestions
        homeMoviesViewModel.suggestionsObservable.subscribe(onNext: { [weak self] (suggestions) in
            self?.setupSuggestionsList(forBeginSearch: suggestions.count > 0)
        }).disposed(by: disposeBag)
        
        // For loading animation
        homeMoviesViewModel.isLoadingAnimation.subscribe(onNext: { [weak self] (isLoading) in
            if isLoading { self?.loadingView.startLoadding() }
            else { self?.loadingView.stopLoadding() }
        }).disposed(by: disposeBag)
        
        // For handling error
        homeMoviesViewModel.errorObservable.subscribe(onNext: { (error) in
            Helper.showAlertViewWith(error: error)
        }).disposed(by: disposeBag)
        
        // Binding for TableView
        homeMoviesViewModel.elements.asObservable()
            .subscribe(onNext: { [weak self] (results) in
                guard let strongSelf = self else { return }
                strongSelf.tableView.dataSource = nil
                strongSelf.tableView.delegate = nil
                
                Observable.just(results)
                    .bind(to: strongSelf.tableView.rx
                                                .items(cellIdentifier: "MovieCell")) { (index, model: Movie, cell) in
                                                    if let cell: MovieCell = cell as? MovieCell {
                                                        cell.setupMovieCellWithModel(model: model)
                                                    }
                    }.disposed(by: strongSelf.disposeBag)
            }).disposed(by: disposeBag)
    }
    
    fileprivate func setupSuggestionsList(forBeginSearch: Bool) {
        if forBeginSearch { self.view.endEditing(true) }
        self.containerView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.containerView.alpha = forBeginSearch ? 1 : 0
        }) { (_) in
            self.containerView.isHidden = !forBeginSearch
        }
    }

}

// MARK: CareemSearchControllerDelegate
extension HomeMoviesViewController: CareemSearchControllerDelegate {
    func didTapOnSearchButton() {
        self.setupSuggestionsList(forBeginSearch: false)
        if let query = careemSearchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.homeMoviesViewModel.queryString.onNext(query)
        }
    }
    
    func didTapOnCancelButton() {
        self.setupSuggestionsList(forBeginSearch: false)
    }
}
