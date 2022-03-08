//
//  HomeVCUITests.swift
//  TemplateUITests
//
//  Created by Apple on 08/03/22.
//

import XCTest

class HomeVCUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//
    
    func testHomeViewSearchingFeatureShowsValidUI() {
        let app = XCUIApplication()
        app.launch()
        
        let songsTableViewTable = app.tables["songsTableView"]
      
        app.searchFields.firstMatch.tap()
        
        app.searchFields.firstMatch.typeText("H")
        
        XCTAssertGreaterThanOrEqual(songsTableViewTable.cells.count, 2 )
    }
    
    func testSearchResultTapShouldRedirectToDetailScreen() {
        let app = XCUIApplication()
        
        app.launch()
        
        let songsTableViewTable = app.tables["songsTableView"]
        
        app.searchFields.firstMatch.tap()
        
        app.searchFields.firstMatch.typeText("H")
        songsTableViewTable.cells.firstMatch.tap()
       
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
