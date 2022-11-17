//
//  AvatarViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation

class AvatarViewModel {
    var avatarService: AvatarService?

    var avatarList: Box<[Avatar]?> = Box(nil)

    func getAvatars() {
        avatarService?.fetchAvatarList({ (result: [Avatar]) in
            self.avatarList.value = result
        })
    }

    func deleteAvatar(avatar: Avatar, at index: Int) {
        avatarService?.deleteAvatar(avatarToDelete: avatar)
        avatarList.value?.remove(at: index)
    }
}
