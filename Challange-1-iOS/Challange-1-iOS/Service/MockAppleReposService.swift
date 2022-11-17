//
//  MockAppleReposService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/20/22.
//

import Foundation
import RxSwift

class MockAppleReposService: AppleReposService {
    var mockedAppleRepos: MockedAppleReposStorage = .init()

    func getAppleReposList(itemsPerPage: Int,
                           pageNumber: Int,
                           _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void) {

        var currentRepos: [AppleRepos] = []
        let endIndex: Int = itemsPerPage * pageNumber
        let startIndex: Int = endIndex - itemsPerPage

        for index in startIndex...endIndex - 1 where index < mockedAppleRepos.appleRepos.count {
            currentRepos.append(mockedAppleRepos.appleRepos[index])
        }

        resultHandler(.success(currentRepos))
    }

    func rxGetAppleReposList(itemsPerPage: Int, pageNumer: Int) -> Single<[AppleRepos]> {
        //        return Single<[Emoji]>.create { [weak self] single in
        //            guard let self = self else {  return Disposables.create() }
        //
        //            single(.success(self.mockedEmojis.emojis))
        //            return Disposables.create()
        //        }
        return Single<[AppleRepos]>.create { single in
            var currentRepos: [AppleRepos] = []
            let endIndex: Int = itemsPerPage * pageNumer
            let startIndex: Int = endIndex - itemsPerPage
            for index in startIndex...endIndex - 1 where index < self.mockedAppleRepos.appleRepos.count {
                currentRepos.append(self.mockedAppleRepos.appleRepos[index])
            }
            single(.success(currentRepos))
            //            single.onNext(currentRepos)

            return Disposables.create()
        }
    }
}
