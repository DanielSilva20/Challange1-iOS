//
//  MockEmojiStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/6/22.
//

import UIKit

class MockEmojiStorage: EmojiService {
    var delegate: EmojiStorageDelegate?
    
    
    private var mockedEmojis: MockedEmojisStorage = .init()
    
    var emojis: [Emoji] = []
    
    func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void) {
        emojis = mockedEmojis.emojis
        guard let url = emojis.randomElement()?.emojiUrl else { return }
        resultUrl(url)
    }
    
    
}
