//
//  MainPageViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit
import RxSwift

public class MainPageViewModel {
    var emojiService: EmojiService?
    var avatarService: AvatarService?

    let emojiImageUrl: Box<URL?> = Box(nil)
    var searchQuery: Box<String?> = Box(nil)

    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
        self.avatarService = avatarService

        self.searchQuery.bind { [weak self] _ in
            self?.searchAvatar()
        }

    }

    func getRandom() {
        emojiService?.getEmojisList {(result: Result<[Emoji], Error>) in
            switch result {
            case .success(let success):
                guard let url = success.randomElement()?.emojiUrl else { return }
                self.emojiImageUrl.value = url
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }

    private func searchAvatar() {
        guard let searchQuery = searchQuery.value else { return }

        avatarService?.getAvatar(searchText: searchQuery, { (result: Result<Avatar, Error>) in
            switch result {
            case .success(let success):
                let avatarUrl = success.avatarUrl
                self.emojiImageUrl.value = avatarUrl
            case .failure(let failure):
                print("Failure: \(failure)")
                self.emojiImageUrl.value = nil
            }
        })
    }
}
