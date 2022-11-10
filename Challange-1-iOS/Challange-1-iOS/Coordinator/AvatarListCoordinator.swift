//
//  AvatarListCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/10/22.
//

import UIKit
import CoreData

class AvatarListCoordinator: Coordinator { var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var avatarViewModel: AvatarViewModel?

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
        let avatarListViewController: AvatarsListViewController = AvatarsListViewController()
        let avatarService: AvatarService = LiveAvatarService(persistentContainer: persistentContainer)
        avatarListViewController.delegate = self
        avatarListViewController.viewModel = AvatarViewModel(avatarService: avatarService)
        self.navigationController.pushViewController(avatarListViewController, animated: true)
    }
}

extension AvatarListCoordinator: AvatarListViewControllerDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
