//
//  Emoji*Mock.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation


class MockedEmojiStorage: EmojiStorage {
    weak var delegate: EmojiStorageDelegate?
    var emojis: [Emoji] = [Emoji(name: "1", url: "https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")]
}

