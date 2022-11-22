//
//  AvatarListViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit
import RxSwift

enum ServiceError: Error {
    case cannotInstanciate
    case deleteError
}

class AvatarListViewModel {
    var avatarService: AvatarService?

    var avatarList: Box<[Avatar]?> = Box(nil)

    init(avatarService: AvatarService) {
        self.avatarService = avatarService
    }

    func getAvatars() -> Single<[Avatar]> {
        //        avatarService?.fetchAvatarList({ (result: [Avatar]) in
        //            self.avatarList.value = result
        //        })
        guard let avatarService = avatarService else {
            return Single<[Avatar]>.error(ServiceError.cannotInstanciate)
        }
        return avatarService.rxFetchAvatarList()
    }

    func deleteAvatar(avatar: Avatar, at index: Int) -> Completable {
//        avatarList.value?.remove(at: index)
        guard let avatarService = avatarService else {
            return Completable.error(ServiceError.deleteError)
        }
        return avatarService.deleteAvatar(avatarToDelete: avatar)
    }
}
