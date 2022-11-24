//
//  EmojiListViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit
import RxSwift

class EmojiListViewModel {
    var emojiService: EmojiService?

    let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage>] = [:]

    init(emojiService: EmojiService) {
        self.emojiService = emojiService
    }

    func imageAtUrl(url: URL) -> Observable<UIImage> {
        Observable<UIImage>
            .deferred { [weak self] in
                guard let self = self else { return Observable.never() }
                let observable = self.ongoingRequests[url.absoluteString]

                if observable == nil {
                    self.ongoingRequests[url.absoluteString] = self.dataOfUrl(url)
                }

                guard let observable = self.ongoingRequests[url.absoluteString] else { return Observable.never() }

                return observable
            }
            .subscribe(on: MainScheduler.instance)
    }

    func dataOfUrl(_ url: URL?) -> Observable<UIImage> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<UIImage> in
                guard let url = url else { return Observable.just(UIImage()) }
                return downloadTask(url: url)
            }
            .share(replay: 1, scope: .forever)
            .observe(on: MainScheduler.instance)
    }

    func rxGetEmojis() -> Single<[Emoji]> {
        guard let emojiService = emojiService else {
            return Single<[Emoji]>.never()
        }
        return emojiService.rxGetEmojisList()
            .flatMap({ result in
                let emojis: [Emoji] = result.sorted()
                return Single<[Emoji]>.just(emojis)
            })
    }
}
