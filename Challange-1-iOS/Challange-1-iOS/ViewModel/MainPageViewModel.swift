//
//  MainPageViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation

public class MainPageViewModel {
    var emojiService: EmojiService?
    
    let emojiImageUrl: Box<URL?> = Box(nil)
    
    init(emojiService: EmojiService) {
        self.emojiService = emojiService
    }
    
    func getRandom() {
        emojiService?.getEmojisList{
            (result: Result<[Emoji], Error>) in
            switch result {
            case .success(let success):
                guard let url = success.randomElement()?.emojiUrl else { return }
                self.emojiImageUrl.value = url
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
}
