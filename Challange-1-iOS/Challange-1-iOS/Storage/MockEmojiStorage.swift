import UIKit

class MockEmojiStorage: EmojiService {

    private var mockedEmojis: MockedEmojisStorage = .init()

    var emojis: [Emoji] = []

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        emojis = mockedEmojis.emojis
        resultHandler(.success(emojis))
    }

}
