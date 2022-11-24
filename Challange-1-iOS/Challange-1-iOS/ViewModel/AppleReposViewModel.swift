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

    var isEnd: Box<Bool> = Box(false)

    private var appleReposArray: [AppleRepos] = []

    private var _rxAppleRepos: PublishSubject<[AppleRepos]> = PublishSubject()
    var rxAppleRepos: Observable<[AppleRepos]> { _rxAppleRepos.asObservable() }

    let disposeBag = DisposeBag()

    init(appleReposService: AppleReposService) {
        self.appleReposService = appleReposService

    }

    func rxGetRepos() {
        guard let appleReposService = appleReposService else {
            return
        }
        self.pageNumber += 1

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
