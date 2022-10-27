import UIKit

protocol AvatarService {
    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void)

    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void)
}
