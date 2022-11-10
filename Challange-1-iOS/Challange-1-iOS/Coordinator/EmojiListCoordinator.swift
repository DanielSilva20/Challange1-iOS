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
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var emojiViewModel: EmojiViewModel?

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
        let emojiListViewController: EmojisListViewController = EmojisListViewController()
        let emojiService: EmojiService = LiveEmojiService(persistentContainer: persistentContainer)
        emojiListViewController.delegate = self
        emojiListViewController.viewModel = EmojiViewModel(emojiService: emojiService)
        self.navigationController.pushViewController(emojiListViewController, animated: true)
    }
}

extension EmojiListCoordinator: EmojiListViewControllerDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
