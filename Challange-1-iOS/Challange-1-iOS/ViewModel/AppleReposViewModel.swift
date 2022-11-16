//
//  AppleReposViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 28/10/2022.
//

import Foundation
import UIKit

import RxSwift

class AppleReposViewModel {
    private var itemsPerPage: Int = 10
    private var pageNumber: Int = 0

    var appleReposService: AppleReposService?

//    var appleReposList: Box<[AppleRepos]?> = Box([])
    var isEnd: Box<Bool> = Box(false)

    private var appleReposArray: [AppleRepos] = []

    private var _rxAppleRepos: PublishSubject<[AppleRepos]> = PublishSubject()
    var rxAppleRepos: Observable<[AppleRepos]> { _rxAppleRepos.asObservable() }

    let disposeBag = DisposeBag()

    init(appleReposService: AppleReposService) {
        self.appleReposService = appleReposService

    }

//    func getRepos() {
//        self.pageNumber += 1
//        self.appleReposService?.getAppleReposList(itemsPerPage: itemsPerPage,
//                                                  pageNumber: pageNumber, { ( result: Result<[AppleRepos], Error>) in
//            switch result {
//            case .success(let success):
//                self.appleReposList.value?.append(contentsOf: success)
//                if success.count < self.itemsPerPage {
//                    self.isEnd.value = true
//                }
//            case .failure(let failure):
//                print("[Error getting appleRepos data] : \(failure)")
//            }
//        })
//    }

    func rxGetRepos() {
        guard let appleReposService = appleReposService else {
            return
        }
        self.pageNumber += 1

//        appleReposService.rxGetAppleReposList(itemsPerPage: itemsPerPage, pageNumer: pageNumber)
//            .debug("RXGETREPOS")
//            .map({ appleRepos -> [AppleRepos] in
//                self.appleReposArray.append(contentsOf: appleRepos)
//                if appleRepos.count < self.itemsPerPage {
//                    self.isEnd.value = true
//                }
//                return self.appleReposArray
//            })
//            .subscribe(_rxAppleRepos)
//            .disposed(by: disposeBag)

        appleReposService.rxGetAppleReposList(itemsPerPage: itemsPerPage, pageNumer: pageNumber)
            .subscribe(onSuccess: { [weak self] appleRepos in
                guard let self = self else { return }
                self.appleReposArray.append(contentsOf: appleRepos)
                if appleRepos.count < self.itemsPerPage {
                    self.isEnd.value = true
                }
                self._rxAppleRepos.onNext(self.appleReposArray)
            })
            .disposed(by: disposeBag)

    }

}
