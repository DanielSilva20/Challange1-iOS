//
//  MainCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var mainPageViewModel: MainPageViewModel?
    var emojiViewModel: EmojiListViewModel?
    var avatarViewModel: AvatarListViewModel?
    var appleReposViewModel: AppleReposViewModel?

    init(emojiService: EmojiService, avatarService: AvatarService, appleReposService: AppleReposService) {
        self.mainPageViewModel = MainPageViewModel(emojiService: emojiService, avatarService: avatarService)
        self.emojiViewModel = EmojiListViewModel(emojiService: emojiService)
        self.avatarViewModel = AvatarListViewModel(avatarService: avatarService)
        self.appleReposViewModel = AppleReposViewModel(appleReposService: appleReposService)
    }

    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            let viewController = EmojisListViewController()
            viewController.coordinator = self
            viewController.viewModel = emojiViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .buttonAvatarsListTapped:
            let viewController = AvatarsListViewController()
            viewController.coordinator = self
            viewController.viewModel = avatarViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .buttonAppleReposTapped:
            let viewController = AppleReposViewController()
            viewController.coordinator = self
            viewController.viewModel = appleReposViewModel
//            viewController.appleReposService = appleReposService
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
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
