//
//  GeralApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/30/22.
//

import Foundation
import UIKit

protocol APIProtocol {
    var url: URL { get }
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

}

func downloadImageFromURL(from url: URL, _ resultHandler: @escaping (Result<UIImage,Error>) -> Void) {
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
        if let data = data {
            if let image = UIImage(data: data) {
                resultHandler(Result<UIImage, Error>.success(image))
            }
        } else if let error = error{
            resultHandler(Result<UIImage, Error>.failure(error))
            
        }
    }
    task.resume()
}
