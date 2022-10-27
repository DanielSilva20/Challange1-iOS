//
//  AppleRepos.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/19/22.
//

import Foundation

struct AppleRepos: Decodable {
    var id: Int
    var fullName: String
    var isPrivate: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case isPrivate = "private"
    }
}
