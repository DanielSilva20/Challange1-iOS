//
//  AppleReposAPI.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/19/22.
//

import Foundation

enum AppleReposApi {
    case getAppleRepos(perPage: Int, page: Int)
}

extension AppleReposApi: APIProtocol {
    
    var url: URL {
        switch self {
            case .getAppleRepos(let perPage, let page):
                var urlComponents = URLComponents(string: "https://api.github.com/users/apple/repos")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "per_page", value: String(perPage)),
                URLQueryItem(name: "page", value: String(page))
            ]
            
            guard let url = urlComponents?.url else { return URL(string: "")!}
            
            return url
        }
    }

    var method: Method {
        switch self {
        case .getAppleRepos:
            return .get
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
