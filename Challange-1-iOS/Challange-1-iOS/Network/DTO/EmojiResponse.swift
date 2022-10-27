//
//  EmojiResponse.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/4/22.
//

import Foundation

struct EmojisAPICAllResult: Decodable {
    var emojis: [Emoji] = []
    let persistence: EmojiPersistence = EmojiPersistence()

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            persistence.saveEmoji(name: key, url: value)
            return Emoji(name: key, emojiUrl: URL(string: value)!)
        }

    }
}
