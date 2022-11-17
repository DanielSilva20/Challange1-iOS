//
//  MainViewControllerDelegate.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/17/22.
//

import Foundation

protocol MainViewControllerDelegate: AnyObject {
    func navigateToEmojiList()
    func navigateToAvatarList()
    func navigateToAppleRepos()
}
