import UIKit

struct Emoji: Codable, CustomStringConvertible {
    let name: String
    let imageUrl: URL

    var description: String {
        "\(name): \(imageUrl)"
    }
}

var EmojiMock: [Emoji] = [Emoji(name: "1", imageUrl: URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                   Emoji(name: "2", imageUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                   Emoji(name: "3", imageUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!),
                   Emoji(name: "4", imageUrl: URL(string:"https://github.githubassets.com/images/icons/emoji/unicode/1f18e.png?v8")!)]



struct EmojisAPICAllResult: Decodable {
    let emojis: [Emoji]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            Emoji(name: key, imageUrl: URL(string: value)!)
        }
    }
}

protocol APIService {
    var method: Method { get }
}

enum EmojiService {
    case getEmojisLive
    case getEmojisMocked
}

extension EmojiService: APIService {
    var method: Method {
        switch self {
        case .getEmojisLive:
            print("getEmojisLive")
        case .getEmojisMocked:
            print("getEmojisMock")
        }
    }
}


func getRandomEmoji(_ call: APIService) {
    
}


func getListEmoji() {
    
}

getRandomEmoji(EmojiService.getEmojisMocked) {
    print("ol")
}
