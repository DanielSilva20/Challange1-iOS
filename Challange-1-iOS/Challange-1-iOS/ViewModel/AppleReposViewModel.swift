//
//  AppleReposViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 28/10/2022.
//

import Foundation

class AppleReposViewModel {
    private var itemsPerPage: Int = 10
    private var pageNumber: Int = 0

    var appleReposService: AppleReposService?

    var appleReposList: Box<[AppleRepos]?> = Box(nil)
    var isEnd: Box<Bool> = Box(false)

    init(appleReposService: AppleReposService) {
        self.appleReposService = appleReposService
    }

    func getRepos() {
        self.pageNumber += 1
        self.appleReposService?.getAppleReposList(itemsPerPage: itemsPerPage,
                                                  pageNumber: pageNumber, { ( result: Result<[AppleRepos], Error>) in
            switch result {
            case .success(let success):
                self.appleReposList.value?.append(contentsOf: success)
                if success.count < self.itemsPerPage {
                    self.isEnd.value = true
                }
            case .failure(let failure):
                print("[Error getting appleRepos data] : \(failure)")
            }
        })
    }
}
