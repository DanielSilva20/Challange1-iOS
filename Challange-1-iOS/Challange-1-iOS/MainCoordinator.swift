//
//  MainCoordinator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        switch type {
        case .buttonEmojisListTapped:
            var vc: UICollectionViewController & Coordinating = EmojisListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAvatarsListTapped:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .buttonAppleReposTapped:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = MainViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
     
}
