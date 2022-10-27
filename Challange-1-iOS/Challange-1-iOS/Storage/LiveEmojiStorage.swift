//
//  LiveEmojiStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation
import CoreData

class LiveEmojiStorage: EmojiService {
    var emojis: [Emoji] = []

    private var networkManager: NetworkManager = .init()
    private let persistence: EmojiPersistence = .init()

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchedEmojis: [NSManagedObject] = []
        fetchedEmojis = persistence.loadData()

        if !fetchedEmojis.isEmpty {
            let emojis = fetchedEmojis.compactMap({ item -> Emoji? in
                guard let nameItem = item.value(forKey: "name") as? String else { return nil }
                guard let urlItem = item.value(forKey: "url") as? URL else { return nil }
                return Emoji(name: nameItem, emojiUrl: urlItem)
            })
            print(emojis.count)
            resultHandler(.success(emojis))
        } else {
            networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojisAPICAllResult, Error>) in
                switch result {
                case .success(let success):
                    resultHandler(.success(success.emojis))
                    //                print("Success: \(success)")
                case .failure(let failure):
                    print("Error: \(failure)")
                }
            }
        }
    }

}
/*
protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiService: EmojiService? { get set }
}
*/
