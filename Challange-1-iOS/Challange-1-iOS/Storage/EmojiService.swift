//
//  EmojiService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/6/22.
//


import UIKit

protocol EmojiService {
    func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void)
    
}


protocol EmojiStorage {
    var delegate: EmojiStorageDelegate? { get set }
    var emojis: [Emoji] { get set }
}
