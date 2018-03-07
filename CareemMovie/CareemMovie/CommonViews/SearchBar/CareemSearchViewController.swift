
//
//  CareemSearchViewController.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol CareemSearchControllerDelegate : NSObjectProtocol {
    func didTapOnCancelButton()
    func didTapOnSearchButton()
}

final class CareemSearchViewController: UISearchController, UISearchBarDelegate {
    
    //MARK: Variables & IBOutlet
    var customSearchBar: CareemSearchBar!
    weak var customDelegate: CareemSearchControllerDelegate?
    private var searchIconOffset: UIOffset!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    // MARK: Initialization
    init(searchResultsController: UIViewController!, searchBar: CareemSearchBar) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(careemSearchBar: searchBar)
        customDelegate = searchResultsController as? CareemSearchControllerDelegate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom functions
    
    func configureSearchBar(careemSearchBar: CareemSearchBar) {
        customSearchBar = careemSearchBar
        customSearchBar.placeholder = "Search.."
        customSearchBar.tintColor = customSearchBar.preferredTextColor
        searchIconOffset = UIOffset(horizontal: (customSearchBar.frame.width - 80) / 2, vertical: 0)
        customSearchBar.setPositionAdjustment(searchIconOffset, for: .search)
        customSearchBar.delegate = self
    }
    
    
    // MARK: UISearchBarDelegate functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate?.didTapOnSearchButton()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customSearchBar.text = ""
        customDelegate?.didTapOnCancelButton()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.customSearchBar.setPositionAdjustment(self.searchIconOffset, for: .search)
        }, completion: nil)
        self.customSearchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.customSearchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        }, completion: nil)
        self.customSearchBar.setShowsCancelButton(true, animated: true)
    }
    
}
