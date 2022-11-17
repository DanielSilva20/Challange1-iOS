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
    private var persistentContainer: NSPersistentContainer
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    var avatars: [Avatar] = []

//    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void) {
//        persistence.fetchAvatarData { (result: [Avatar]) in
//            if result.count != 0 {
//                resultHandler(result)
//            }
//        }
//    }

    func rxFetchAvatarList() -> Single<[Avatar]> {
        persistence.rxFetchAvatarData()
    }

//    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void) {
//        persistence.checkIfItemExist(login: searchText) { (result: Result<[Avatar], Error>) in
//            switch result {
//            case .success(let success):
//                if !success.isEmpty {
//                    guard let avatar = success.first else { return }
//                    resultHandler(.success(avatar))
//                } else {
//                    self.networkManager.executeNetworkCall(
//                        AvatarAPI.getAvatars(searchText)) { (result: Result<Avatar, Error>) in
//                        switch result {
//                        case .success(let success):
//                            self.persistence.saveAvatar(currentAvatar: success)
//                            resultHandler(.success(success))
//                        case .failure(let failure):
//                            print("Error: \(failure)")
//                        }
//                    }
//                }
//            case .failure(let failure):
//                print("Error: \(failure)")
//            }
//        }
//    }

    func deleteAvatar(avatarToDelete: Avatar) {
        persistence.delete(avatarObject: avatarToDelete)
    }

    func rxGetAvatar(avatarName: String) -> Observable<Avatar> {
        persistence.rxCheckIfItemExist(avatarName: avatarName)
            .flatMap({ avatar -> Observable<Avatar> in
                guard let avatar = avatar else {
                    return self.networkManager.rxExecuteNetworkCall(AvatarAPI.getAvatars(avatarName))
                        .do { (result: Avatar) in
                            self.persistence.saveAvatar(currentAvatar: result)
                        }
                        .asObservable()
                }
                return Observable.just(avatar)
        })
    }

}

//
// protocol AvatarPresenter: AvatarStorageDelegate {
//    var avatarService: AvatarService? { get set }
// }
