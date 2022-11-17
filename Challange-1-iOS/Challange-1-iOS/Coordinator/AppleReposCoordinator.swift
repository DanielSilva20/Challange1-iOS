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

    var appleReposViewModel: AppleReposViewModel?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let appleReposViewController: AppleReposViewController = AppleReposViewController()
        let appleReposService: AppleReposService = MockAppleReposService()
        appleReposViewController.delegate = self
        appleReposViewController.viewModel = AppleReposViewModel(appleReposService: appleReposService)
        self.navigationController.pushViewController(appleReposViewController, animated: true)
    }
}

extension AppleReposCoordinator: BackToMainViewControllerDelegate {
    func navigateBackToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
