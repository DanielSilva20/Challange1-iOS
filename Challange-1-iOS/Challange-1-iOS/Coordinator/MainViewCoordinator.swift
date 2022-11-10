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
    unowned let navigationController: UINavigationController

    var mainPageViewModel: MainPageViewModel?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func start() {
        let mainViewController: MainViewController = MainViewController()
        let emojiService: EmojiService = LiveEmojiService(persistentContainer: persistentContainer)
        let avatarService: AvatarService = LiveAvatarService(persistentContainer: persistentContainer)
        let viewModel: MainPageViewModel = MainPageViewModel(emojiService: emojiService, avatarService: avatarService)
        mainViewController.viewModel = viewModel
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
    }
}

extension MainViewCoordinator: MainViewControllerDelegate {
    func navigateToEmojiList() {
        let emojiListCoordinator = EmojiListCoordinator(navigationController: navigationController)
        emojiListCoordinator.delegate = self
        childCoordinators.append(emojiListCoordinator)
        emojiListCoordinator.start()
    }

    func navigateToAvatarList() {
//        let avatarListCoordinator = AvatarListCoordinator(navigationController: navigationController)
//        avatarListCoordinator.delegate = self
//        childCoordinators.append(avatarListCoordinator)
//        avatarListCoordinator.start()
    }

    func navigateToAppleRepos() {
//        let appleReposCoordinator = AppleReposCoordinator(navigationController: navigationController)
//        appleReposCoordinator.delegate = self
//        childCoordinators.append(appleReposCoordinator)
//        appleReposCoordinator.start()
    }
}

extension MainViewCoordinator: BackToMainViewControllerDelegate {

    func navigateBackToMainPage(newOrderCoordinator: EmojiListCoordinator) {
//        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
