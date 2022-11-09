//
//  Emoji*Mock.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation

class MockedEmojisStorage {

    var emojis: [Emoji] = [Emoji(name: "1", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f18e.png?v8")!),
                           Emoji(name: "2", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f3b1.png?v8")!),
                           Emoji(name: "3", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f947.png?v8")!),
                           Emoji(name: "4", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f948.png?v8")!),
                           Emoji(name: "5", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f949.png?v8")!),
                           Emoji(name: "6", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/25c0.png?v8")!),
                           Emoji(name: "7", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/23ec.png?v8")!),
                           Emoji(name: "8", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f6f0.png?v8")!),
                           Emoji(name: "9", emojiUrl: URL(string: "\(Constants.baseUrlEmoji)/1f951.png?v8")!)
    ]
}
