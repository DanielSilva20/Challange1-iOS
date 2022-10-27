//
//  EmojiViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation

class EmojiViewModel {
    var emojiService: EmojiService?
    
    let emojisList: Box<[Emoji]?> = Box(nil)
    
    init(emojiService: EmojiService) {
        self.emojiService = emojiService
    }
    
    func getEmojis() {
        emojiService?.getEmojisList({ (result: Result<[Emoji], Error>) in
            switch result {
            case .success(var success):
                success.sort()
                self.emojisList.value = success
            case .failure(let failure):
                print("Error: \(failure)")
            }
        })
    }
}
