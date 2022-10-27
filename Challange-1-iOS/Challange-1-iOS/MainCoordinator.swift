//
//  MainCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var emojiService: EmojiService?
    var avatarService: AvatarService?
    var appleReposService: AppleReposService?

    var navigationController: UINavigationController?

    var liveAvatarStorage: LiveAvatarStorage = .init()
    var mainPageViewModel: MainPageViewModel?
    var emojiViewModel: EmojiViewModel?
    var avatarViewModel: AvatarViewModel?

    init(emojiService: EmojiService, avatarService: AvatarService, appleReposService: AppleReposService) {
        self.emojiService = emojiService
        self.avatarService = avatarService
        self.appleReposService = appleReposService
        self.mainPageViewModel = MainPageViewModel(emojiService: emojiService, avatarService: avatarService)
        self.emojiViewModel = EmojiViewModel(emojiService: emojiService)
        self.avatarViewModel = AvatarViewModel(avatarService: avatarService)
    }

    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            let vc = EmojisListViewController()
            vc.coordinator = self
//            vc.emojiService = emojiService
            vc.viewModel = emojiViewModel
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAvatarsListTapped:
            let vc = AvatarsListViewController()
            vc.coordinator = self
            vc.avatarService = liveAvatarStorage
            vc.viewModel = avatarViewModel
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAppleReposTapped:
            let vc = AppleReposViewController()
            vc.coordinator = self
            vc.appleReposService = appleReposService
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.emojiService = emojiService
        vc.avatarService = liveAvatarStorage
        vc.viewModel = mainPageViewModel
        navigationController?.setViewControllers([vc], animated: false)
    }

}

// extension MainCoordinator: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        navigationController?.viewControllers.forEach {
//            ($0 as? EmojiPresenter)?.emojiListUpdated()
//        }
//    }
// }
//
// extension MainCoordinator: AvatarStorageDelegate {
//    func avatarListUpdated() {
//        navigationController?.viewControllers.forEach {
//            ($0 as? AvatarPresenter)?.avatarListUpdated()
//        }
//    }
// }
