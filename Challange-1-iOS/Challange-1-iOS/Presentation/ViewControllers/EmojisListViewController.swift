//
//  EmojisList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class EmojisListViewController: UIViewController, Coordinating {
    private var collectionView: UICollectionView
    var coordinator: Coordinator?
    var emojisList: [Emoji] = []
    var viewModel: EmojiViewModel?

    //    lazy var collectionView: UICollectionView = {
    //        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    //        return v
    //    }()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
    }

    private func setUpViews() {
        setUpCollectionView()
    }

    private func addViewsToSuperview() {
        view.addSubview(collectionView)
    }

    private func setUpConstraints() {
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

        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.reuseCellIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.emojisList.bind(listener: { [weak self] emojiArray in
            guard let emojiArray = emojiArray else { return }
            self?.emojisList = emojiArray
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        })
        viewModel?.getEmojis()
    }
}

// extension EmojisListViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        collectionView.reloadData()
//    }
// }

extension EmojisListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let countEmojis = emojisList.count

        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = emojisList[indexPath.row].emojiUrl

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

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
