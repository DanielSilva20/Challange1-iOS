

import UIKit

protocol AvatarService {
    func getAvatar(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void)
}

