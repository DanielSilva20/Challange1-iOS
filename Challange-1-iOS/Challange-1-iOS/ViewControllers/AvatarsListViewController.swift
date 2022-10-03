//
//  AvatarsList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class AvatarsListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatars List"
        view.backgroundColor = .systemBlue
    }
    
}
