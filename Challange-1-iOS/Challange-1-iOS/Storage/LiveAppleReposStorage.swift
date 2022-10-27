//
//  LiveAppleReposStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/19/22.
//

import Foundation

class LiveAppleReposStorage: AppleReposService {

    private var networkManager: NetworkManager = .init()

    func getAppleReposList(itemsPerPage: Int, pageNumber: Int, _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void) {
        networkManager.executeNetworkCall(AppleReposApi.getAppleRepos(perPage: itemsPerPage, page: pageNumber)) { (result: Result<[AppleRepos], Error>) in
            switch result {
            case .success(let success):
                resultHandler(.success(success))
            case .failure(let failure):
                resultHandler(.failure(failure))
                print("Error: \(failure)")
            }
        }
    }
}
