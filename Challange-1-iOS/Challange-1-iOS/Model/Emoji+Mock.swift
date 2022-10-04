//
//  Emoji*Mock.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation

class MockedEmojisStorage: EmojiStorage {
    weak var delegate: EmojiStorageDelegate?
    var emojis: [Emoji] = [Emoji(name: "1", emojiUrl: URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "2", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "3", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "4", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "5", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "6", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "7", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "8", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                           Emoji(name: "9", emojiUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
    ]
}


