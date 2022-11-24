//
//  EmojiService.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/6/22.
//

import UIKit
import RxSwift

protocol EmojiService {
    func rxGetEmojisList() -> Single<[Emoji]>
}
