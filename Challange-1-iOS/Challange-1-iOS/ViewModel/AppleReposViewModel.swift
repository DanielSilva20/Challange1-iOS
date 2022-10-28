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
//    private var isEnd: Bool = false

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
//                self.appleReposList.append(contentsOf: success)
                self.appleReposList.value = success
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
//                    self.tableView.reloadData()
//                    if self.tableView.contentSize.height < self.tableView.frame.size.height {
//                        self.getCurrentRepos()
//                    }
                }
                if success.count < self.itemsPerPage {
                    self.isEnd.value = true
                }
            case .failure(let failure):
                print("[Error getting appleRepos data] : \(failure)")
            }
        })
    }
}
