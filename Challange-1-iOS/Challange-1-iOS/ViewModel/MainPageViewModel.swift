//
//  MainPageViewModel.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/27/22.
//

import Foundation
import UIKit
import RxSwift

public class MainPageViewModel {
    var application: Application

    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")

    private var rxEmojiImageUrl: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    private var _rxEmojiImage: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    var rxEmojiImage: Observable<UIImage?> { _rxEmojiImage.asObservable() }

    private var rxSearchAvatarName: PublishSubject<String> = PublishSubject()
    private var _rxSearchAvatar: PublishSubject<UIImage?> = PublishSubject()
    var rxSearchAvatar: Observable<UIImage?> { _rxSearchAvatar.asObservable() }

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

    init(application: Application) {
        self.application = application

        rxEmojiImageUrl
            .debug("rxEmojiImageUrl")
            .flatMap({ [weak self] url -> Observable<UIImage?> in
                guard let self = self else { return Observable.never() }

                let observable = self.ongoingRequests[url?.absoluteString ?? ""]

                // Verifica se o url já foi guardado no ongoingRequests
                if observable == nil {
                    self.ongoingRequests[url?.absoluteString ?? ""] = self.dataOfUrl(url).share(replay: 1,
                                                                                                scope: .forever)
                }

                guard let observable =
                        self.ongoingRequests[url?.absoluteString ?? ""] else { return Observable.never() }

                return observable
            })
            .debug("rxEmojiImage")
            .subscribe(_rxEmojiImage)
            .disposed(by: disposeBag)

        rxSearchAvatarName
            .debug("rxSearchAvatarName")
            .flatMap({ avatarName in
                return application.avatarService.rxGetAvatar(avatarName: avatarName)
            })
            .flatMap({ avatar -> Observable<UIImage?> in
                return self.dataOfUrl(avatar.avatarUrl)
            })
            .debug("rxSearchAvatar")
            .subscribe(_rxSearchAvatar)
            .disposed(by: disposeBag)

        print("end init")
    }

    func dataOfUrl(_ url: URL?) -> Observable<UIImage?> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<Data> in
                guard let url = url else { return Observable.just(Data()) }
                guard let data = try? Data(contentsOf: url) else { return Observable.just(Data()) }
                return Observable.just(data)
            }
            .map {
                UIImage(data: $0) ?? nil
            }
            .observe(on: MainScheduler.instance)
            .debug("dataOfUrl")
    }

    func rxGetRandomEmoji() {
        application.emojiService.rxGetEmojisList()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] emojis in
                    guard
                        let self = self
                    else { return }
                    let randomUrl = emojis.randomElement()?.emojiUrl
                    self.rxEmojiImageUrl.onNext(randomUrl)
                }, onFailure: { error in
                    print("[rxGetRandomEmoji-ViewModel] \(error)")
                }, onDisposed: {
                    print("[rxGetRandomEmoji-ViewModel] - Disposed")
                })
            .disposed(by: disposeBag)
    }

    func rxSearchAvatarName(avatarName: String) {
        rxSearchAvatarName.onNext(avatarName)
    }
}
