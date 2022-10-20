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
        let endIndex: Int = itemsPerPage * pageNumber - 1
        var index: Int = endIndex - itemsPerPage
        
        while (index < endIndex) {
            index += 1
            currentRepos.append(mockedAppleRepos.appleRepos[index])
        }
        
        resultHandler(.success(currentRepos))
    }
}
