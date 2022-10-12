//
//  LiveAvatarStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 03/10/2022.
//

import Foundation

class LiveAvatarStorage: AvatarService {
    func getAvatarList(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {
        
    }
    
    weak var delegate: AvatarStorageDelegate?
    var avatars: [Avatar] = []
    
    init(){
        loadAvatars()
    }
    
    func loadAvatars() {
        
    }
}


protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarService: AvatarService? { get set }
}
