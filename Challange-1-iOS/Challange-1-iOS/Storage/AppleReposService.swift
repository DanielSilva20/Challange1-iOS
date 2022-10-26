//
//  AppleReposService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/20/22.
//

import Foundation

protocol AppleReposService {
    func getAppleReposList(itemsPerPage: Int, pageNumber: Int, _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void)
}
