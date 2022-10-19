//
//  AppleRepos.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class AppleReposViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Repos"
        view.backgroundColor = .appColor(name: .surface)
    }

}
