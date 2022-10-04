//
//  EmojiResponse.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/4/22.
//

import Foundation

struct EmojisAPICAllResult: Decodable {
    let emojis: [Emoji]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            Emoji(name: key, emojiUrl: URL(string: value)!)
        }
    }
}

