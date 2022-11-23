//
//  AvatarsList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit
import RxSwift

class AvatarsListViewController: BaseGenericViewController<AvatarsListView> {
    weak var delegate: BackToMainViewControllerDelegate?
    var avatars: [Avatar] = []
    var viewModel: AvatarListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatars List"
        genericView.collectionView.dataSource = self
        genericView.collectionView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.viewModel?.avatarList.bind(listener: { [weak self] avatarList in
        //            guard
        //                let self = self,
        //                let avatarList = avatarList else { return }
        //            self.avatars = avatarList
        //            DispatchQueue.main.async {
        //                self.genericView.collectionView.reloadData()
        //            }
        //        })

        viewModel?.getAvatars()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] success in
                guard let self = self else { return }
                self.avatars = success
            }, onFailure: { error in
                print("[GET AVATARS LIST] -  \(error)")
            }, onDisposed: {
                print("[GET AVATARS LIST] - Disposed")
            })
            .disposed(by: disposeBag)
    }

    deinit {
        self.delegate?.navigateBackToMainPage()
    }
}

extension AvatarsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return avatars.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AvatarCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = avatars[indexPath.row].avatarUrl

        cell.setUpCell(url: url)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let avatar = self.avatars[indexPath.row]
        let alert = genericView.createDeleteAlert(name: avatar.login) { [weak self] in
            guard let self = self else { return }
            self.viewModel?.deleteAvatar(avatar: avatar)
                .subscribe(onCompleted: {
                    self.avatars.remove(at: indexPath.row)
                    self.genericView.collectionView.reloadData()
                    print("Avatar deleted")
                    }, onError: { error in
                        print("ERROR DELETING: \(error)")
                    })
                .disposed(by: self.disposeBag)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
