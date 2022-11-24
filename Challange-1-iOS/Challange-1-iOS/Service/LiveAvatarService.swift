//
//  LiveAvatarService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation
import CoreData
import RxSwift

class LiveAvatarService: AvatarService {
    private var networkManager: NetworkManager = .init()
    private var persistence: AvatarPersistence {
        return .init(persistentContainer: persistentContainer)
    }
    let disposeBag = DisposeBag()
    private var persistentContainer: NSPersistentContainer
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    var avatars: [Avatar] = []

    func rxFetchAvatarList() -> Single<[Avatar]> {
        persistence.rxFetchAvatarData()
    }

    func delete(_ avatar: Avatar) -> Completable {
        persistence.delete(avatar: avatar)
    }

    func rxGetAvatar(avatarName: String) -> Observable<Avatar> {
        persistence.rxCheckIfItemExist(avatarName: avatarName)
            .flatMap({ avatar -> Observable<Avatar> in
                guard let avatar = avatar else {
                    return self.networkManager.rx.executeNetworkCall(AvatarAPI.getAvatars(avatarName))
                        .do { (result: Avatar) in
                            self.persistence.save(avatar: result).subscribe(onError: { error in
                                print("Error saving Avatar from API call: \(error)")
                            })
                            .disposed(by: self.disposeBag)
                        }
                        .asObservable()
                }
                return Observable.just(avatar)
            })
    }

}
