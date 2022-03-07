//
//  NetworkEngine.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation

class NetworkEngine {
    
    var urlSession: URLSession!
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T?, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.host = endpoint.baseURL
        urlComponents.path = endpoint.path
        urlComponents.scheme = endpoint.scheme
        urlComponents.queryItems = endpoint.params
        urlComponents.port = endpoint.port
        
        guard let url = urlComponents.url else { return } //should call completion handler
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
        
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    let resultModel = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(resultModel))
                
                } catch let error {
                    
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
