//
//  EmojiViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit

import RxSwift

class EmojiViewModel {
    var emojiService: EmojiService?

//    let emojisList: Box<[Emoji]?> = Box(nil)
//    let rxEmojiList: Observable<[Emoji]?>

    let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage>] = [:]

    private var _rxEmojiList: PublishSubject<[Emoji]?> = PublishSubject()
    var rxEmojiList: Observable<[Emoji]?> { _rxEmojiList.asObservable() }

    init(emojiService: EmojiService) {
        self.emojiService = emojiService
        _rxEmojiList.disposed(by: disposeBag)
    }

    func imageAtUrl(url: URL) -> Observable<UIImage> {
        Observable<UIImage>
            .deferred { [weak self] in
                guard let self = self else { return Observable.never() }
                let observable = self.ongoingRequests[url.absoluteString]

                // Verifica se o url já foi guardado no ongoingRequests
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

    func getEmojis() {
        emojiService?.getEmojisList({ (result: Result<[Emoji], Error>) in
            switch result {
            case .success(var success):
                success.sort()
                self._rxEmojiList.onNext(success)
            case .failure(let failure):
                print("Error: \(failure)")
            }
        })
    }
}
