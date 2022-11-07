//
//  EmojiService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/6/22.
//

import UIKit

protocol EmojiService {
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void)
}
