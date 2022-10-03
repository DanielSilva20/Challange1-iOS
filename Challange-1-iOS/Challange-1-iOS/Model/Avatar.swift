//
//  Avatar.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation

struct Avatar: Codable, CustomStringConvertible {
    var login: String
    var id: Int
    var avatarUrl: URL

    var description: String {
        "\(login):\(id) :\(avatarUrl)"
    }
}
