//
//  ItunesAPIService.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation

protocol ItunesApiServiceProtocol {
    func getSongs(for text: String, completion: @escaping (Result<ItunesResultModel?, Error>) -> Void)
}

struct ItunesApiService: ItunesApiServiceProtocol {
    func getSongs(for text: String, completion: @escaping (Result<ItunesResultModel?, Error>) -> Void) {
        
        let networkEngine = NetworkEngine(urlSession: URLSession.init(configuration: .default))
        let itunesEndpoint = ItunesEndpoint.getSongs(searchTerm: text)
        networkEngine.request(endpoint: itunesEndpoint) { (itunesResult: Result<ItunesResultModel?, Error>) in
           completion(itunesResult)
        }
    }
}
