//
//  AvatarListCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/10/22.
//

import UIKit
import CoreData

class AvatarListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var avatarService: AvatarService?

    required init(navigationController: UINavigationController, avatarService: AvatarService) {
        self.navigationController = navigationController
        self.avatarService = avatarService
    }

    func start() {
        let avatarListViewController: AvatarsListViewController = AvatarsListViewController()
        avatarListViewController.delegate = self
        let viewModel = AvatarViewModel()
        viewModel.avatarService = avatarService
        avatarListViewController.viewModel = viewModel
        self.navigationController.pushViewController(avatarListViewController, animated: true)
    }
}

extension AvatarListCoordinator: AvatarListViewControllerDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
