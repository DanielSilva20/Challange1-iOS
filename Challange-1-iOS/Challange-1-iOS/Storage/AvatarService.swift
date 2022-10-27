

import UIKit

protocol AvatarService {
    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void)
}

