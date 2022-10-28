//
//  MockEmojisDataSource.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import UIKit

class MockedDataSource: NSObject, UICollectionViewDataSource {
    var mockedEmojis: MockEmojiStorage = .init()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return mockedEmojis.emojis.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = mockedEmojis.emojis[indexPath.row].emojiUrl

        cell.setUpCell(url: url)

        return cell
    }
}
