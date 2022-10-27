//
//  MockAppleReposStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/20/22.
//

import Foundation

class MockAppleReposStorage: AppleReposService {
    var mockedAppleRepos: MockedAppleReposStorage = .init()

    func getAppleReposList(itemsPerPage: Int, pageNumber: Int, _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void) {

        var currentRepos: [AppleRepos] = []
        let endIndex: Int = itemsPerPage * pageNumber
        let startIndex: Int = endIndex - itemsPerPage

        for index in startIndex...endIndex - 1 {
            if index < mockedAppleRepos.appleRepos.count {
                currentRepos.append(mockedAppleRepos.appleRepos[index])
            }
        }

        resultHandler(.success(currentRepos))
    }
}
