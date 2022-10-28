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
            let viewController = EmojisListViewController()
            viewController.coordinator = self
//            vc.emojiService = emojiService
            viewController.viewModel = emojiViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .buttonAvatarsListTapped:
            let viewController = AvatarsListViewController()
            viewController.coordinator = self
            viewController.avatarService = liveAvatarStorage
            viewController.viewModel = avatarViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .buttonAppleReposTapped:
            let viewController = AppleReposViewController()
            viewController.coordinator = self
            viewController.appleReposService = appleReposService
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        viewController.emojiService = emojiService
        viewController.avatarService = liveAvatarStorage
        viewController.viewModel = mainPageViewModel
        navigationController?.setViewControllers([viewController], animated: false)
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
