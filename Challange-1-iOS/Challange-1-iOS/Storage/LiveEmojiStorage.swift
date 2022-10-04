//
//  LiveEmojiStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation

class LiveEmojiStorage: EmojiStorage {
    var emojis: [Emoji] = []
    weak var delegate: EmojiStorageDelegate?
    
    private var networkManager: NetworkManager = .init()
    
    init(){
//        loadEmojis()
    }

//    func loadEmojis() {
//        networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojisAPICAllResult, Error>) in
//            switch result {
//            case .success(let success):
//                self.emojis = success.emojis
//                self.emojis.sort()
//                DispatchQueue.main.async {
//                    self.delegate?.emojiListUpdated()
//                }
//                print("Success: \(success)")
//            case .failure(let failure):
//                print("Error: \(failure)")
//            }
//        }
//    }
    
    
    func fetchEmojis(_ resultHandler: @escaping (EmojisAPICAllResult) -> Void) {
        networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojisAPICAllResult, Error>) in
            switch result {
            case .success(let success):
                resultHandler(success)
//                print("Success: \(success)")
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
    func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void) {
        // fetch emojis and return a random emoji
        fetchEmojis { (result: EmojisAPICAllResult) in
            guard let randomUrl = result.emojis.randomElement()?.emojiUrl else { return }
            
            resultUrl(randomUrl)
        }
    }
}

protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiStorage: EmojiStorage? { get set }
}

protocol EmojiStorage {
    var delegate: EmojiStorageDelegate? { get set }
    var emojis: [Emoji] { get set }
}
