//
//  GeralApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/30/22.
//

import Foundation
import UIKit

protocol APIProtocol {
    var url: URL { get set }
    var method: Method { get }
    var headers: [String: String] { get }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case unknownError
}

class NetworkManager {
    
    static func initialize() {
        URLSession.shared.configuration.urlCache?.diskCapacity = 100 * 1024 * 1024
        print("Current disk cache capacity: \(String(describing: URLSession.shared.configuration.urlCache?.diskCapacity))")
    }
    
    func executeNetworkCall<ResultType: Decodable>(_ call: APIProtocol, _ resultHandler: @escaping (Result<ResultType, Error>) -> Void) {
        let decoder = JSONDecoder()
        var request = URLRequest(url: call.url)
        request.httpMethod = call.method.rawValue
        call.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let result = try? decoder.decode(ResultType.self, from: data) {
                    resultHandler(Result<ResultType, Error>.success(result))
                } else {
                    resultHandler(Result<ResultType, Error>.failure(APIError.unknownError))
                }
            } else if let error = error {
                resultHandler(Result<ResultType, Error>.failure(error))
            }
        }

        task.resume()
    }
    
//    func loadJson(fromURLString urlString: String,
//                  resultHandler: @escaping (Result<Data, Error>) -> Void) {
//        let decoder = JSONDecoder()
//
//        if let url = URL(string: urlString) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    if let result = try? decoder.decode(Data.self, from: data) {
//                        print(result)
//                        resultHandler(.success(result))
//                    } else {
//                        resultHandler(.failure(APIError.unknownError))
//                    }
//                }
//                if let error = error {
//                    resultHandler(.failure(error))
//                }
//            }
//
//            task.resume()
//        }
//    }
    
    func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }

}
