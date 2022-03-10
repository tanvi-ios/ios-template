//
//  ItunesAPIService.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation
import RxSwift

protocol ItunesApiServiceProtocol {
    func getSongs(for text: String) -> Observable<ItunesResultModel>
}

struct ItunesApiService: ItunesApiServiceProtocol {
    func getSongs(for text: String) -> Observable<ItunesResultModel> {
        
        let networkEngine = NetworkEngine(urlSession: URLSession.init(configuration: .default))
        let itunesEndpoint = ItunesEndpoint.getSongs(searchTerm: text)
        return networkEngine.request(endpoint: itunesEndpoint)
        
    }
}
