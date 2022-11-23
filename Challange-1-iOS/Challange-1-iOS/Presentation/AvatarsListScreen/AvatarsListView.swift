//
//  AvatarsListView.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/4/22.
//

import UIKit

class AvatarsListView: BaseGenericView {
    var collectionView: UICollectionView

    required init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createViews() {
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
    }

    private func setUpViews() {
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseCellIdentifier)

        //        collectionView.delegate = self
    }

    private func addViewsToSuperview() {
        addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
