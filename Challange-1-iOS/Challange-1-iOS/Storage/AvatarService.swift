//
//  AvatarService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/12/22.
//


import UIKit

protocol AvatarService {
    func getAvatarList(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void)
}

