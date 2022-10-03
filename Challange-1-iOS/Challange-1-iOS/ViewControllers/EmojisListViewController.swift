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
        
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
    }
    
    private func setUpViews(){
        setUpCollectionView()
    }
    
    private func addViewsToSuperview(){
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        title = "Emojis List"
        view.backgroundColor = .systemBlue

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)

        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.delegate = self
        collectionView.dataSource = self
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Emojis: \(String(describing: emojiStorage?.emojis.count))")
        
    }
}

extension EmojisListViewController: EmojiStorageDelegate {
    func emojiListUpdated() {
        collectionView.reloadData()
    }
}


extension EmojisListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let countEmojis = emojiStorage?.emojis.count ?? 0
        
        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCell else {
            return UICollectionViewCell()
        }

        let url = (emojiStorage?.emojis[indexPath.row].emojiUrl)!
        
        cell.setUpCell(url: url)
        
        return cell
    }
}


extension EmojisListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
