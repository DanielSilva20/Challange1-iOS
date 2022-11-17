//
//  AppleReposCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/10/22.
//

import UIKit
import CoreData

class AppleReposCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var appleReposService: AppleReposService?

    required init(navigationController: UINavigationController, appleReposService: AppleReposService) {
        self.navigationController = navigationController
        self.appleReposService = appleReposService
    }

    func start() {
        let appleReposViewController: AppleReposViewController = AppleReposViewController()
        guard let appleReposService = appleReposService else { return }
        let viewModel = AppleReposViewModel(appleReposService: appleReposService)
        appleReposViewController.delegate = self
        appleReposViewController.viewModel = viewModel
        self.navigationController.pushViewController(appleReposViewController, animated: true)
    }
}

extension AppleReposCoordinator: BackToMainViewControllerDelegate {
    func navigateBackToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
