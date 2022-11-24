//
//  AvatarListViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit
import RxSwift

class AvatarListViewModel {
    var avatarService: AvatarService?

    init(avatarService: AvatarService) {
        self.avatarService = avatarService
    }

    func getAvatars() -> Single<[Avatar]> {
        guard let avatarService = avatarService else {
            return Single<[Avatar]>.error(ServiceError.cannotInstanciate)
        }
        return avatarService.rxFetchAvatarList()
    }

    func delete(_ avatar: Avatar) -> Completable {
        guard let avatarService = avatarService else {
            return Completable.error(ServiceError.deleteError)
        }
        return avatarService.delete(avatar)
    }
}
