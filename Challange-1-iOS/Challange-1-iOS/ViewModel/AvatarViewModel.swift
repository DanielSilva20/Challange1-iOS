//
//  AvatarViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation

class AvatarViewModel {
    var avatarService: AvatarService?

    let avatarList: Box<[Avatar]?> = Box(nil)

    init(avatarService: AvatarService) {
        self.avatarService = avatarService
    }

    func getAvatars() {
        avatarService?.fetchAvatarList({ (result: [Avatar]) in
            self.avatarList.value = result
        })
    }
}
