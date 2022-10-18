//
//  LiveAvatarStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation
import CoreData

class LiveAvatarStorage: AvatarService {

//    var currentAvatar: AvatarData?

    private var networkManager: NetworkManager = .init()
    private var avatarPersistence: AvatarPersistence = .init()
    
    var avatars: [Avatar] = []

    
    init(){
        
    }

    func getAvatar(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {

    }
    
    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void){
        avatarPersistence.fetchAvatarData() { (result: [NSManagedObject]) in
            if result.count != 0 {
                let avatars = result.map({ item in
                    return item.ToAvatar()
                })
                resultHandler(avatars)
            }
        }
    }
    
    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void){
        avatarPersistence.checkIfItemExist(login: searchText) { (result: Result<[NSManagedObject], Error>) in
            switch result {
            case .success(let success):
                if !success.isEmpty {
                    guard let avatar = success.first else { return }
                    resultHandler(.success(avatar.ToAvatar()))
                } else {
                    self.networkManager.executeNetworkCall(AvatarAPI.getAvatars(searchText)) { (result: Result<Avatar, Error>) in
                        switch result {
                        case .success(let success):
                            self.avatarPersistence.saveAvatar(currentAvatar: success)
                            resultHandler(.success(success))
                        case .failure(let failure):
                            print("Error: \(failure)")
                        }
                    }
                }
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
    func deleteAvatar(avatarToDelete: Avatar) {
        print("Delete \(avatarToDelete.login)")
    }
    
}


protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarService: AvatarService? { get set }
}
