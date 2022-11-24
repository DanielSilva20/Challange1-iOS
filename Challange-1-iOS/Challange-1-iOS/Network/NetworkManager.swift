//
//  GeralApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/30/22.
//

import Foundation
import UIKit
import RxSwift

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
    case parseError
}

class NetworkManager: ReactiveCompatible {

    static func initialize() {
        URLSession.shared.configuration.urlCache?.diskCapacity = 100 * 1024 * 1024
    }

    func executeNetworkCall<ResultType: Decodable>(_ call: APIProtocol,
                                                   _ resultHandler: @escaping (Result<ResultType, Error>) -> Void) {
        let decoder = JSONDecoder()
        var request = URLRequest(url: call.url)
        request.httpMethod = call.method.rawValue
        call.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                if let result = try? decoder.decode(ResultType.self, from: data) {
                    resultHandler(.success(result))
                } else {
                    resultHandler(.failure(APIError.unknownError))
                }
            } else if let error = error {
                resultHandler(.failure(error))
            }
        }

        task.resume()
    }
}

extension Reactive where Base: NetworkManager {
    func executeNetworkCall<ResultType: Decodable>(_ call: APIProtocol) -> Single<ResultType> {
        let decoder = JSONDecoder()
        var request = URLRequest(url: call.url)
        request.httpMethod = call.method.rawValue
        call.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return Single<ResultType>.create { single in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                guard let data = data,
                      let result = try? decoder.decode(ResultType.self, from: data)
                else {
                    single(.failure(APIError.parseError))
                    return
                }
                single(.success(result))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
