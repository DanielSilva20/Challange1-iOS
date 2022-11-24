//
//  Errors.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/24/22.
//

import Foundation

enum ServiceError: Error {
    case cannotInstanciate
    case deleteError
}

enum PersistenceError: Error {
    case fetchError
    case saveError
    case deleteError
    case selfError
}
