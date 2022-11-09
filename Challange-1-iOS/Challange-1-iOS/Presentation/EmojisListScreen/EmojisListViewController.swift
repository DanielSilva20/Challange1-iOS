//
//  EmojisList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit
import RxSwift

class EmojisListViewController: BaseGenericViewController<EmojisListView>, Coordinating {
    var coordinator: Coordinator?
    var emojisList: [Emoji] = []
    var viewModel: EmojiViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        genericView.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.emojisList.bind(listener: { [weak self] emojiArray in
            guard let emojiArray = emojiArray else { return }
            self?.emojisList = emojiArray
            DispatchQueue.main.async { [weak self] in
                self?.genericView.collectionView.performBatchUpdates({
                    self?.genericView.collectionView.reloadData()
                })
//                self?.genericView.collectionView.reloadData()
            }
        })
        viewModel?.getEmojis()
    }
}

extension EmojisListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let countEmojis = emojisList.count

        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = emojisList[indexPath.row].emojiUrl

        guard let viewModel = viewModel else { return UICollectionViewCell() }
        viewModel.imageAtUrl(url: url)
            .asOptional()
            .subscribe(cell.imageView.rx.image)
            .disposed(by: cell.reusableDisposeBag)
//        viewModel.rxEmojiImage
//            .subscribe(cell.imageView.rx.image)
//            .disposed(by: disposeBag)
//        cell.setUpCell(viewModel: viewModel)
//        cell.setUpCell(url: url)

        return cell
    }
}

// extension EmojisListViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        collectionView.reloadData()
//    }
// }
