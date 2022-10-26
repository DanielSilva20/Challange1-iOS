//
//  AvatarApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation

enum AvatarAPI {
    case getAvatars(String)
}

extension AvatarAPI: APIProtocol {
    
    var url: URL {
        switch self {
        case .getAvatars(let name):
            return URL(string: "\(Constants.baseUrl)/users/\(name)")!
        }
    }

    var method: Method {
        switch self {
        case .getAvatars:
            return .get
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
