//
//  EmojiListCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/10/22.
//

import UIKit
import CoreData

class EmojiListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var emojiService: EmojiService?

    init(navigationController: UINavigationController, emojiService: EmojiService) {
        self.emojiService = emojiService
        self.navigationController = navigationController
    }

    func start() {
        let emojiListViewController: EmojisListViewController = EmojisListViewController()
        emojiListViewController.delegate = self
        let viewModel = EmojiViewModel()
        viewModel.emojiService = emojiService
        emojiListViewController.viewModel = viewModel
        self.navigationController.pushViewController(emojiListViewController, animated: true)
    }
}

extension EmojiListCoordinator: BackToMainViewControllerDelegate {
    func navigateBackToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
