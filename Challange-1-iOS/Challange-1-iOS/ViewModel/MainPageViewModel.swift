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
    var emojiService: EmojiService?
    var avatarService: AvatarService?

    let emojiImageUrl: Box<URL?> = Box(nil)
    var searchQuery: Box<String?> = Box(nil)

    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")

    private var rxEmojiImageUrl: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    private var _rxEmojiImage: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    var rxEmojiImage: Observable<UIImage?> { _rxEmojiImage.asObservable() }

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
        self.avatarService = avatarService

        self.searchQuery.bind { [weak self] _ in
            self?.searchAvatar()
        }

        rxEmojiImageUrl
            .debug("rxEmojiImageUrl")
            .flatMap({ [weak self] url -> Observable<UIImage?> in
                guard let self = self else { return Observable.never() }
                var observable = self.ongoingRequests[url?.absoluteString ?? ""]

                if observable == nil {
                    self.ongoingRequests[url?.absoluteString ?? ""] = self.dataOfUrl(url).share(replay: 1, scope: .forever)
                }

                guard let observable = self.ongoingRequests[url?.absoluteString ?? ""] else { return Observable.never() }

                return observable
            })
            .debug("rxEmojiImage")
            .subscribe(_rxEmojiImage)
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
                UIImage(data: $0) ?? UIImage()
            }
            .observe(on: MainScheduler.instance)
            .debug("dataOfUrl")
    }

    func downloadUrl(_ url: URL?) -> Observable<UIImage?> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<Data> in
                guard let url = url else { return Observable.just(Data()) }
                guard let data = try? Data(contentsOf: url) else { return Observable.just(Data()) }
                return Observable.just(data)
            }
            .map {
                UIImage(data: $0) ?? UIImage()
            }
            .observe(on: MainScheduler.instance)
            .debug("dataOfUrl")
    }

    func getRandom() {
        emojiService?.getEmojisList {(result: Result<[Emoji], Error>) in
            switch result {
            case .success(let success):
                guard let url = success.randomElement()?.emojiUrl else { return }
                self.emojiImageUrl.value = url
                self.rxEmojiImageUrl.onNext(url)
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }

    private func searchAvatar() {
        guard let searchQuery = searchQuery.value else { return }

        avatarService?.getAvatar(searchText: searchQuery, { (result: Result<Avatar, Error>) in
            switch result {
            case .success(let success):
                let avatarUrl = success.avatarUrl
                self.emojiImageUrl.value = avatarUrl
                self.rxEmojiImageUrl.onNext(avatarUrl)
            case .failure(let failure):
                print("Failure: \(failure)")
                self.emojiImageUrl.value = nil
            }
        })
    }
}
