//
//  ItunesAPIServiceTest.swift
//  TemplateTests
//
//  Created by Apple on 07/03/22.
//

import XCTest
@testable import Template

class ItunesAPIServiceTests: XCTestCase {

    func testAPIServiceFailure() {
        let mock = MockItunesAPIService()
        mock.getSongs(for: "") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual("Search text can not be empty", error.localizedDescription)
            case .success(_):
                break
            }
        }
    }

    func testAPIServiceSuccess() {
        let mock = MockItunesAPIService()
        mock.getSongs(for: "H") { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let songs):
                XCTAssertNotNil(songs)
                XCTAssertEqual(1, songs?.resultCount)
            }
        }
    }
}
