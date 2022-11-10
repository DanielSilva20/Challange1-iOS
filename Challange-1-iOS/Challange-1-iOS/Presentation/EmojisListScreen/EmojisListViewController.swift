//
//  EmojisList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

public protocol EmojiListViewControllerDelegate: AnyObject {
    func navigateToMainPage()
}

class EmojisListViewController: BaseGenericViewController<EmojisListView> {
    public weak var delegate: EmojiListViewControllerDelegate?
    var emojisList: [Emoji] = []
    var viewModel: EmojiViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        genericView.collectionView.dataSource = self

//        genericView.btnBack = UIBarButtonItem(title: "Back",
//                                              style: .plain,
//                                              target: self,
//                                              action: #selector(navigateBackToMainPage))
//        self.navigationItem.leftBarButtonItem = genericView.btnBack
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.emojisList.bind(listener: { [weak self] emojiArray in
            guard let emojiArray = emojiArray else { return }
            self?.emojisList = emojiArray
            DispatchQueue.main.async { [weak self] in
                self?.genericView.collectionView.reloadData()
            }
        })
        viewModel?.getEmojis()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.navigateToMainPage()
    }

//    @objc func navigateBackToMainPage() {
//        self.delegate?.navigateToMainPage()
//    }
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

        cell.setUpCell(url: url)

        return cell
    }
}

// extension EmojisListViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        collectionView.reloadData()
//    }
// }
