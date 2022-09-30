//
//  GeralApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/30/22.
//

import Foundation

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
