//
//  Endpoint.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation

protocol Endpoint {
    
    var scheme: String {get}
    var path: String {get}
    var baseURL: String {get}
    var params: [URLQueryItem] {get}
    var method: String { get }
    var port: Int? { get }
    
}
