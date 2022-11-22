//
//  Constants.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/25/22.
//

import Foundation

enum Constants {
    static let baseUrl: String = "https://api.github.com"
    static let baseUrlEmoji: String = "https://github.githubassets.com/images/icons/emoji/unicode"
}

enum ServiceError: Error {
    case cannotInstanciate
    case deleteError
}

enum PersistenceError: Error {
    case fetchError
    case saveError
    case deleteError
}
