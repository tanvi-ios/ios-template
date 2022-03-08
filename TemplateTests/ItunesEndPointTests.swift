//
//  ItunesEndPointTests.swift
//  TemplateTests
//
//  Created by Apple on 07/03/22.
//

import XCTest
@testable import Template

class ItunesEndPointTests: XCTestCase {


    func test_Itunes_Endpoint_with_InvalidData_Returns_Failure() {
        let endpoint = ItunesEndpoint.getSongs(searchTerm: "H")
        XCTAssertNotEqual(endpoint.scheme, "http")
        XCTAssertNotEqual(endpoint.baseURL, "localhost")
        XCTAssertEqual(endpoint.path, "/search")
        XCTAssertTrue(endpoint.params.contains(URLQueryItem(name: "term", value: "H")))
        XCTAssertEqual(endpoint.method, "get")
    }
    
    func test_Itunes_Endpoint_with_ValidData_Returns_Success() {
        let endpoint = ItunesEndpoint.getSongs(searchTerm: "H")
        XCTAssertEqual(endpoint.scheme, "https")
        XCTAssertEqual(endpoint.baseURL, "itunes.apple.com")
        XCTAssertEqual(endpoint.path, "/search")
        XCTAssertTrue(endpoint.params.contains(URLQueryItem(name: "term", value: "H")))
        XCTAssertEqual(endpoint.method, "get")
    }

}
