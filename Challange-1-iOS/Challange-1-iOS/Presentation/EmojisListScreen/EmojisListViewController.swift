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
    var emojisList: [Emoji]?
    var viewModel: EmojiListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        genericView.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel?.rxEmojiList
//            .subscribe(rx.emojisList)
//            .disposed(by: disposeBag)
//        viewModel?.getEmojis()
        viewModel?.rxGetEmojis()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] emojiList in
                guard let self = self else { return }
                self.emojisList = emojiList
                self.genericView.collectionView.reloadData()
            }, onFailure: { error in
                print("[GET EMOJIS LIST] -  \(error)")
            }, onDisposed: {
                print("[GET EMOJIS LIST] - Disposed")
            })
            .disposed(by: disposeBag)
    }
}

extension EmojisListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let countEmojis = emojisList?.count else { return 0 }

        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCell = collectionView.dequeueReusableCell(for: indexPath)

        guard let url = emojisList?[indexPath.row].emojiUrl else { return UICollectionViewCell() }

        guard let viewModel = viewModel else { return UICollectionViewCell() }
        viewModel.imageAtUrl(url: url)
            .asOptional()
            .subscribe(cell.imageView.rx.image)
            .disposed(by: cell.reusableDisposeBag)

        return cell
    }
}

// extension EmojisListViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        collectionView.reloadData()
//    }
// }
