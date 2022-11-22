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
    let disposeBag = DisposeBag()

    private var networkManager: NetworkManager = .init()
    private var persistentContainer: NSPersistentContainer
    private var persistence: EmojiPersistence {
        return .init(persistentContainer: persistentContainer)
    }
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            emojis.forEach { emoji in
                self.persistence.saveEmoji(name: emoji.name, url: emoji.emojiUrl.absoluteString)
                    .subscribe(onError: { error in
                        print("Error saving Emojis from API call: \(error)")
                    })
                    .disposed(by: self.disposeBag)
            }
        }
    }
}
