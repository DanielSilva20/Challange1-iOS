//
//  MainCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, EmojiPresenter, AvatarPresenter {
    var emojiService: EmojiService?
    
    var avatarService: AvatarService?
    var navigationController: UINavigationController?

    var liveEmojiStorage: LiveEmojiStorage = .init()
    var liveAvatarStorage: LiveAvatarStorage = .init()
    
    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
        
        self.avatarService = avatarService
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            let vc = EmojisListViewController()
            vc.coordinator = self
            vc.emojiService = emojiService
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAvatarsListTapped:
            let vc = AvatarsListViewController()
            vc.coordinator = self
            vc.avatarService = liveAvatarStorage
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAppleReposTapped:
            let vc = AppleReposViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.emojiService = emojiService
        vc.avatarService = liveAvatarStorage
        navigationController?.setViewControllers([vc], animated: false)
    }
     
}

extension MainCoordinator: EmojiStorageDelegate {
    func emojiListUpdated() {
        navigationController?.viewControllers.forEach {
            ($0 as? EmojiPresenter)?.emojiListUpdated()
        }
    }
}

extension MainCoordinator: AvatarStorageDelegate {
    func avatarListUpdated() {
        navigationController?.viewControllers.forEach {
            ($0 as? AvatarPresenter)?.avatarListUpdated()
        }
    }
}
