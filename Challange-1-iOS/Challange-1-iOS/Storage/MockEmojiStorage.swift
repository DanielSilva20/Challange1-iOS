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
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        emojis = mockedEmojis.emojis
        resultHandler(.success(emojis))
    }

}
