//
//  LiveEmojiStorage.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
//

import Foundation
import CoreData

class LiveEmojiStorage: EmojiService {
    var emojis: [Emoji] = []
    
    private var networkManager: NetworkManager = .init()
    private let persistence: EmojiPersistence = .init()
    
    init(){
        
    }
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchedEmojis : [NSManagedObject] = []
        fetchedEmojis = persistence.loadData()
        
        if !fetchedEmojis.isEmpty {
            let emojis = fetchedEmojis.map({ item in
                return Emoji(name: item.value(forKey: "name") as! String, emojiUrl: URL(string: item.value(forKey: "url") as! String)!)
            })
            print(emojis.count)
            resultHandler(.success(emojis))
        } else {
            networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojisAPICAllResult, Error>) in
                switch result {
                case .success(let success):
                    resultHandler(.success(success.emojis))
                    //                print("Success: \(success)")
                case .failure(let failure):
                    print("Error: \(failure)")
                }
            }
        }
    }
    
}

protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiService: EmojiService? { get set }
}



