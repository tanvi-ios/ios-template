//
//  HomeVMTest.swift
//  TemplateTests
//
//  Created by Apple on 07/03/22.
//

import XCTest
@testable import Template

class HomeVMTests: XCTestCase {

    var homeVM: HomeVM!
    var mockAPIService: MockItunesAPIService!
    
    override func setUp() {
        mockAPIService = MockItunesAPIService()
        homeVM = HomeVM(with: mockAPIService)
    }
    
    func test_get_songs_with_valid_data_returns_success() {
        homeVM.getSearchResult("H")
        
        XCTAssertEqual(homeVM.itunesResults.count, 1)
    }

    func test_get_songs_with_invalid_data_returns_failure() {
        homeVM.getSearchResult("")
        
        XCTAssertTrue(homeVM.itunesResults.isEmpty)
    }
}
