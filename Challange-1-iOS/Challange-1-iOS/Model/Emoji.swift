//
//  Emoji.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation

struct Emoji: Codable, CustomStringConvertible {
    var name: String
    var emojiUrl: URL

    var description: String {
        "\(name): \(emojiUrl)"
    }
}

extension Emoji: Comparable {
    static func < (lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.name < rhs.name
    }
}
