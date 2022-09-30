//
//  Emoji.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation

struct Emoji {
    var name: String
    var url: String
}

extension Emoji: Comparable {
    static func < (lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.name < rhs.name
    }
}
