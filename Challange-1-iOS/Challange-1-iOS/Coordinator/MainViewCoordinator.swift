//
//  AppCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/10/22.
//

import UIKit
import CoreData

final class MainViewCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    var application: Application

    required init(navigationController: UINavigationController, application: Application) {
        self.navigationController = navigationController
        self.application = application
    }

    func start() {
        let mainViewController: MainViewController = MainViewController()
        let viewModel: MainPageViewModel = MainPageViewModel(application: application)
        viewModel.application.emojiService = application.emojiService
        viewModel.application.avatarService = application.avatarService
        mainViewController.viewModel = viewModel
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
    }
}

extension MainViewCoordinator: MainViewControllerDelegate {
    func navigateToEmojiList() {
        let emojiListCoordinator = EmojiListCoordinator(navigationController: navigationController,
                                                        emojiService: application.emojiService)
        emojiListCoordinator.delegate = self
        childCoordinators.append(emojiListCoordinator)
        emojiListCoordinator.start()
    }

    func navigateToAvatarList() {
        let avatarListCoordinator = AvatarListCoordinator(navigationController: navigationController,
                                                          avatarService: application.avatarService)
        avatarListCoordinator.delegate = self
        childCoordinators.append(avatarListCoordinator)
        avatarListCoordinator.start()
    }

    func navigateToAppleRepos() {
        let appleReposCoordinator = AppleReposCoordinator(navigationController: navigationController,
                                                          appleReposService: application.appleReposService)
        appleReposCoordinator.delegate = self
        childCoordinators.append(appleReposCoordinator)
        appleReposCoordinator.start()
    }
}

extension MainViewCoordinator: BackToMainViewControllerDelegate {
    func navigateBackToMainPage() {
        childCoordinators.removeLast()
    }
}
