//
//  LiveAvatarStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation

struct AvatarData: Codable {
    let login: String
    let id: Int
    let avatar_url: String
}


class LiveAvatarStorage: AvatarService {
    

    var currentAvatar: AvatarData?

    private var networkManager: NetworkManager = .init()
    
    weak var delegate: AvatarStorageDelegate?
    var avatars: [Avatar] = []
    var avatarPersistence: AvatarPersistence?
    
    init(){
        
    }

    func getAvatar(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {

    }
    
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(AvatarData.self,
                                                       from: jsonData)
            
            print("Login: ", decodedData.login)
            print("Id: ", decodedData.id)
            print("AvatarUrl: ", decodedData.avatar_url)
            print("===================================")
            currentAvatar = decodedData
        } catch {
            print("decode error")
        }
    }
}


protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarService: AvatarService? { get set }
}
