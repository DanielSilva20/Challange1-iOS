import UIKit
import RxSwift

protocol AvatarService {
    func rxFetchAvatarList() -> Single<[Avatar]>
    func delete(_ avatar: Avatar) -> Completable
    func rxGetAvatar(avatarName: String) -> Observable<Avatar>
}
