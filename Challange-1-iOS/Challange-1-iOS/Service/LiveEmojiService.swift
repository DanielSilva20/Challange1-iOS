import Foundation
import CoreData
import RxSwift

class LiveEmojiService: EmojiService {
    var emojis: [Emoji] = []
    let disposeBag = DisposeBag()

    private var networkManager: NetworkManager = .init()
    private var persistentContainer: NSPersistentContainer
    private let persistence: EmojiPersistence
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistence = EmojiPersistence.init(persistentContainer: persistentContainer)
    }

    func rxGetEmojisList() -> Single<[Emoji]> {
        return persistence.rxFetchEmojisData()
            .flatMap({ fetchedEmojis in
                if fetchedEmojis.isEmpty {
                    return self.networkManager.rx.executeNetworkCall(EmojiAPI.getEmojis)
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
                self.persistence.save(emoji: emoji)
                    .subscribe(onError: { error in
                        print("Error saving Emojis from API call: \(error)")
                    })
                    .disposed(by: self.disposeBag)
            }
        }
    }
}
