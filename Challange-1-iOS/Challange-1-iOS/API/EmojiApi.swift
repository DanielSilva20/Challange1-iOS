//
//  EmojiApi.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/30/22.
//

import Foundation

enum EmojiAPI {
    case getEmojis
    case postEmoji
}

extension EmojiAPI: APIProtocol {

    var url: URL {
        URL(string: "https://api.github.com/emojis")!
    }

    var method: Method {
        switch self {
        case .getEmojis:
            return .get
        case .postEmoji:
            return .post
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}

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

