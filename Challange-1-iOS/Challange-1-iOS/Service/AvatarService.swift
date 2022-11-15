import UIKit
import RxSwift

protocol AvatarService {
//    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void)

    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void)

    func deleteAvatar(avatarToDelete: Avatar)

    func rxGetAvatar(avatarName: String) -> Observable<Avatar>
}
