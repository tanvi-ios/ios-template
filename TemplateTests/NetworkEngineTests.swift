//
//  NetworkEngineTests.swift
//  TemplateTests
//
//  Created by Apple on 08/03/22.
//

import XCTest
@testable import Template

class NetworkEngineTests: XCTestCase {

    func testNetworkEngineWithValidRequestReturnsModelClass() {
        let engine = NetworkEngine(urlSession: URLSession(configuration: .ephemeral))
        
        let endPoint = ItunesEndpoint.getSongs(searchTerm: "H")
        
        let expectation = self.expectation(description: "Fetching Data")
        
        engine.request(endpoint: endPoint) { (result: Result<ItunesResultModel?, Error>) in
            switch result {
            case .failure(_):
                break
            case .success(let responseData):
                let data = try! XCTUnwrap(responseData)
                XCTAssertNotNil(data)
                XCTAssertTrue(!data.results.isEmpty)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkEngineWithInvalidRequestReturnsError() {
        let engine = NetworkEngine(urlSession: URLSession(configuration: .ephemeral))
        
        let endPoint = ItunesEndpoint.getSongs(searchTerm: "")
        
        let expectation = self.expectation(description: "Fetching Data")
        
        engine.request(endpoint: endPoint) { (result: Result<ItunesResultModel?, Error>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(_):
                break
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
