import UIKit
import Alamofire
import CoreData

class MainViewController: BaseGenericViewController<MainView>, Coordinating {
    var coordinator: Coordinator?
    var networkManager: NetworkManager = .init()
    var viewModel: MainPageViewModel?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.emojiImage.showLoading()

        viewModel?.rxEmojiImage
            .do(onNext: { [weak self] _ in
                self?.genericView.emojiImage.stopLoading()
            })
            .subscribe(genericView.emojiImage.rx.image)
            .disposed(by: disposeBag)

        getRandomEmoji()

        self.navigationController?.navigationBar.tintColor = .appColor(name: .primary)

        // Code for RxSwift
                genericView.rxRandomEmojiTap
                    .subscribe(onNext: { [weak self] _ in
                        self?.getRandomEmoji()
                    })
                    .disposed(by: disposeBag)
                genericView.rxEmojiListTap
                    .subscribe(onNext: { [weak self] _ in
                        self?.didTapEmojisLIst()
                    })
                genericView.rxAvatarListTap
                    .subscribe(onNext: { [weak self] _ in
                        self?.didTapAvatarsList()
                    })
                genericView.rxAppleReposTap
                    .subscribe(onNext: { [weak self] _ in
                        self?.didTapAppleRepos()
                    })
                genericView.rxSearchTap
                    .subscribe(onNext: { [weak self] _ in
                        self?.saveSearchContent()
                    })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func didTapEmojisLIst() {
        coordinator?.eventOccurred(with: .buttonEmojisListTapped)
    }

    func didTapAvatarsList() {
        coordinator?.eventOccurred(with: .buttonAvatarsListTapped)
    }

    func didTapAppleRepos() {
        coordinator?.eventOccurred(with: .buttonAppleReposTapped)
    }

    func getRandomEmoji() {
        viewModel?.getRandom()
    }

    func saveSearchContent() {
        viewModel?.searchQuery.value = genericView.searchBar.text
        genericView.searchBar.text = ""
    }
}

// extension MainViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        getRandomEmoji()
//    }
// }
