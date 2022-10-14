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
    
    weak var delegate: AvatarStorageDelegate?
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
    
//    func parse(jsonData: Data) {
//        do {
//            let decodedData = try JSONDecoder().decode(AvatarData.self,
//                                                       from: jsonData)
//            
//            print("Login: ", decodedData.login)
//            print("Id: ", decodedData.id)
//            print("AvatarUrl: ", decodedData.avatar_url)
//            print("===================================")
//            currentAvatar = decodedData
//        } catch {
//            print("decode error")
//        }
//    }
    
    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void){
        avatarPersistence.checkIfItemExist(login: searchText) { (result: Result<[NSManagedObject], Error>) in
            switch result {
            case .success(let success):
                if !success.isEmpty {
                    guard let avatar = success.first else { return }
                    resultHandler(.success(avatar.ToAvatar()))
                } else {
                    let decoder = JSONDecoder()
                    var request = URLRequest(url: URL(string: "https://api.github.com/users/\(searchText)")!)
                    request.httpMethod = Method.get.rawValue
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data = data {
                            if let result = try? decoder.decode(Avatar.self, from: data) {
                                self.avatarPersistence.saveAvatar(currentAvatar: result)
                                resultHandler(.success(result))
                            } else {
                                resultHandler(.failure(APIError.unknownError))
                            }
                        } else if let error = error {
                            resultHandler(.failure(error))
                        }
                    }

                    task.resume()
                }
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }

    }
    
}


protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarService: AvatarService? { get set }
}
