//
//  NetworkEngine.swift
//  Template
//
//  Created by Apple on 04/03/22.
//

import Foundation
import RxSwift

class NetworkEngine {
    
    var urlSession: URLSession!
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
//    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T?, Error>) -> Void) {
//        var urlComponents = URLComponents()
//        urlComponents.host = endpoint.baseURL
//        urlComponents.path = endpoint.path
//        urlComponents.scheme = endpoint.scheme
//        urlComponents.queryItems = endpoint.params
//        urlComponents.port = endpoint.port
//        
//        guard let url = urlComponents.url else { return } //should call completion handler
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = endpoint.method
//        
//        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
//            
//            guard error == nil else {
//                completion(.failure(error!))
//                return
//            }
//            
//            guard response != nil, let data = data else { return }
//            
//            DispatchQueue.main.async {
//                do {
//                    let resultModel = try JSONDecoder().decode(T.self, from: data)
//                    completion(.success(resultModel))
//                    
//                } catch let error {
//                    
//                    completion(.failure(error))
//                }
//            }
//        }
//        dataTask.resume()
//    }
//    
    func request<T: Codable>(endpoint: Endpoint) -> Observable<T> {
        
        return Observable<T>.create { [weak self] observer in
            var urlComponents = URLComponents()
            urlComponents.host = endpoint.baseURL
            urlComponents.path = endpoint.path
            urlComponents.scheme = endpoint.scheme
            urlComponents.queryItems = endpoint.params
            urlComponents.port = endpoint.port
            
            guard let url = urlComponents.url else {
                return observer.onError(APIServiceError.somethingWrong) as! Disposable
                
            } //should call completion handler
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method
            
            let dataTask = self?.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard response != nil, let data = data else { return }
                
                DispatchQueue.main.async {
                    do {
                        let resultModel = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(resultModel)
                        observer.onCompleted()
                    } catch let error {
                        
                        observer.onError(error)
                    }
                }
            }
            dataTask?.resume()
            
            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
}
