//
//  ItunesEndpoint.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation

enum ItunesEndpoint: Endpoint {
    var scheme: String {
        switch self {
        default :
            return CommandLine.arguments.contains("-debug") ? "http" : "https"
        }
    }
    
    var path: String {
        switch self {
        case .failure:
            return "/fail"
        case .getSongs:
            return "/search"
        }
    }
    
    var baseURL: String {
        switch self {
        default :
            return CommandLine.arguments.contains("-debug") ? "localhost" : "itunes.apple.com"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .failure:
            return []
        case .getSongs(let searchTerm) :
            return [URLQueryItem(name: "term", value: searchTerm), URLQueryItem(name: "media", value: "music")]
        }
    }
    
    var method: String {
        return "get"
    }
    
    var port: Int? {
        switch self {
        default:
            return CommandLine.arguments.contains("-debug") ? 9999 : nil
        }
    }
    
    
    case getSongs(searchTerm: String)
    case failure
    
}
