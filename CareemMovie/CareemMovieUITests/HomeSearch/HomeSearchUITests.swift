//
//  HomeSearchUITests.swift
//  CareemMovieUITests
//
//  Created by Tran Hoang Canh on 9/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import XCTest

/* TEST CASES:
 1. Type the keyword and search
 2. Choose one of list suggestion and see the results. Condition: Should have more than 1 suggestion first
 */

class HomeSearchUITests: BaseUITest {
    
    // MARK: - Base functions
    func typeSearchBar(withText: String) {
        let searchBar = app.searchFields.firstMatch
        waitUntilElementExists(searchBar)
        inputTextToTextField(searchBar, text: withText)
        
        let searchButton = app.buttons["Search"]
        waitUntilElementExists(searchButton)
        searchButton.tap()
    }
    
    func scrollTableViewToLoadMore(tableView: XCUIElement) {
        waitUntilElementExists(tableView)
        while tableView.cells.count <= 20 {
            tableView.swipeUp()
        }
        sleep(3)
        XCTAssert(tableView.cells.count > 20)
    }
    
    // MARK: - Test cases
    func testSearchMovieWithKeyWordIronMan() {
        let tableResults = app.tables.firstMatch
        
        typeSearchBar(withText: "Iron man")
        
        waitUntilElementExists(tableResults)
        
        XCTAssert(tableResults.cells.count > 5)
        
        scrollTableViewToLoadMore(tableView: tableResults)
    }
    
    func testChooseSuggestionList() {
        let resultTableView = app.tables.firstMatch
        
        let searchBar = app.searchFields.firstMatch
        waitUntilElementExists(searchBar)
        inputTextToTextField(searchBar, text: "")
        
        let suggestionTableView = app.tables["SuggestionsTableView"]
        waitUntilElementExists(suggestionTableView)
        
        if suggestionTableView.cells.count > 1 {
            suggestionTableView.cells.element(boundBy: 1).tap()
            scrollTableViewToLoadMore(tableView: resultTableView)
        }
        
    }
    
}
