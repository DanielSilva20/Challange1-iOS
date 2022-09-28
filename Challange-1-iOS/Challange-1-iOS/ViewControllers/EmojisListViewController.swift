//
//  EmojisList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class EmojisListViewController: UICollectionViewController, Coordinating {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        view.backgroundColor = .systemBlue
    }
}
