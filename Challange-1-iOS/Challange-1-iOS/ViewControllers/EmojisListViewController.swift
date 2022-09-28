//
//  EmojisList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class EmojisListViewController: UIViewController, Coordinating, EmojiPresenter {
    var coordinator: Coordinator?
    var emojiStorage: EmojiStorage?
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        view.backgroundColor = .systemBlue
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Emojis: \(emojiStorage?.emojis.count)")
        
    }
}

extension EmojisListViewController: EmojiStorageDelegate {
    func emojiListUpdated() {
        print("Emojis: \(emojiStorage?.emojis.count)")
        collectionView.reloadData()
    }
}
