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
    
    var avatarPersistence: AvatarPersistence = AvatarPersistence()
    
    //O avatar Storage só precisa de ser chamada quando se clica no avatars list button
    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
        
        self.avatarService = avatarService
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            var vc: UIViewController & Coordinating & EmojiPresenter = EmojisListViewController()
            vc.coordinator = self
            vc.emojiService = emojiService
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAvatarsListTapped:
            var vc = AvatarsListViewController()
            vc.coordinator = self
            vc.avatarService = avatarService
            vc.avatarPersistence = avatarPersistence
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAppleReposTapped:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc = MainViewController()
        vc.coordinator = self
        vc.emojiService = emojiService
        vc.avatarPersistence = avatarPersistence
        navigationController?.setViewControllers([vc], animated: false)
    }
     
}

//É preciso fazer abstração nestas extensões?

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
