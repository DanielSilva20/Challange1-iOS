//
//  RandomEmoji.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class RandomEmojiViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random Emojis"
        view.backgroundColor = .systemBlue
    }
}
