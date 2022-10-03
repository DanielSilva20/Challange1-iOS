//
//  MainCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, EmojiPresenter {
    var navigationController: UINavigationController?
    var emojiStorage: EmojiStorage?
    
    init(emojiStorage: EmojiStorage) {
        self.emojiStorage = emojiStorage
        self.emojiStorage?.delegate = self
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            var vc: UIViewController & Coordinating & EmojiPresenter = EmojisListViewController()
            vc.coordinator = self
            vc.emojiStorage = emojiStorage
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAvatarsListTapped:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAppleReposTapped:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating & EmojiPresenter = MainViewController()
        vc.coordinator = self
        vc.emojiStorage = emojiStorage
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
