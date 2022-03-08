//
//  HomeVM.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation
import UIKit

class HomeVM {
    var itunesResults = [SongModel]()
    let itunesAPIService: ItunesApiServiceProtocol
    var searchedText = ""
    var reloadData: (() -> Void)?
    var passError: ((Error) -> Void)?
    
    init(with itunesAPIService: ItunesApiServiceProtocol) {
        self.itunesAPIService = itunesAPIService
    }
    
    func getSearchResult(_ searchText: String) {
        itunesAPIService.getSongs(for: searchText) { [weak self] (itunesResult) in
            switch(itunesResult) {
            case .failure(let error):
                print("error is \(error)")
                if let pass = self?.passError {
                    pass(error)
                }
            case .success(let searchResult):
                print("result is \(String(describing: searchResult?.resultCount))")
                if let results = searchResult?.results, !results.isEmpty {
                    self?.itunesResults = results
                } else {
                    self?.itunesResults = []
                }
                if let reload = self?.reloadData {
                    reload()
                }
            }
        }
    }
    
}
