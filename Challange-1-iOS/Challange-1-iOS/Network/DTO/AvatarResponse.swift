import UIKit

struct AvatarAPICAllResult: Decodable {
    var avatars: [Avatar] = []

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let avatarsAsDictionary = try container.decode([String: String].self)
        avatars = avatarsAsDictionary.map { (key: String, value: String) in
//            return Emoji(name: key, emojiUrl: URL(string: value)!)
            return Avatar(login: key, id: 2, avatarUrl: URL(string: value)!)
        }
       
    }
}

