//
//  AppleReposService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/20/22.
//

import Foundation

import RxSwift

protocol AppleReposService {
    func getAppleReposList(itemsPerPage: Int,
                           pageNumber: Int,
                           _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void)

    func rxGetAppleReposList(itemsPerPage: Int, pageNumer: Int) -> Observable<[AppleRepos]>
}
