//
//  Coordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation

import UIKit

enum Event {
    case buttonEmojisListTapped
    case buttonAvatarsListTapped
    case buttonAppleReposTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiStorage: EmojiStorage? { get set }
}

protocol EmojiStorage {
    var delegate: EmojiStorageDelegate? { get set }
    var emojis: [Emoji] { get set }
}

protocol EmojiStorageDelegate: AnyObject {
    func emojiListUpdated()
}
