import UIKit
import RxSwift

class MockEmojiService: EmojiService {

    private var mockedEmojis: MockedEmojisStorage = .init()

    var emojis: [Emoji] = []

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        emojis = mockedEmojis.emojis
        resultHandler(.success(emojis))
    }

    func rxGetEmojisList() -> Single<[Emoji]> {
        return Single<[Emoji]>.create { [weak self] single in
            guard let self = self else {  return Disposables.create() }

            single(.success(self.mockedEmojis.emojis))
            return Disposables.create()
        }
    }
}
