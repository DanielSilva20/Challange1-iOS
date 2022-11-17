//
//  LiveEmojiService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation
import CoreData
import RxSwift

class LiveEmojiService: EmojiService {
    var emojis: [Emoji] = []

    private var networkManager: NetworkManager = .init()
    private var persistentContainer: NSPersistentContainer
    private var persistence: EmojiPersistence {
        return .init(persistentContainer: persistentContainer)
    }
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchedEmojis: [Emoji] = []
        fetchedEmojis = persistence.fetchEmojisData()

        if !fetchedEmojis.isEmpty {
            resultHandler(.success(fetchedEmojis))
        } else {
            networkManager.executeNetworkCall(
                EmojiAPI.getEmojis) { [weak self] (result: Result<EmojisAPICAllResult, Error>) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        success.emojis.forEach { emoji in
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                self.persistence.saveEmoji(name: emoji.name, url: emoji.emojiUrl.absoluteString)
                            }
                        }
                        resultHandler(.success(success.emojis))
                    case .failure(let failure):
                        print("Error: \(failure)")
                    }
                }
        }
    }

    func rxGetEmojisList() -> Single<[Emoji]> {
        return persistence.rxFetchEmojisData()
            .flatMap({ fetchedEmojis in
                if fetchedEmojis.isEmpty {
                    return self.networkManager.rxExecuteNetworkCall(EmojiAPI.getEmojis)
                        .map { (emojisResult: EmojisAPICAllResult) in
                            self.persistEmojis(emojis: emojisResult.emojis)
                            return emojisResult.emojis
                        }
                }
                return Single<[Emoji]>.just(fetchedEmojis)
            })
    }

    func persistEmojis(emojis: [Emoji]) {
        emojis.forEach { emoji in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.persistence.saveEmoji(name: emoji.name, url: emoji.emojiUrl.absoluteString)
            }
        }
    }
}
