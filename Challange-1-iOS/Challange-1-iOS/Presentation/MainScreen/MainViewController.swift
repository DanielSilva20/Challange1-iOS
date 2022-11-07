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
            .do(onNext: { [weak self] image in
                self?.genericView.emojiImage.stopLoading()
                // Arranjar forma de mudar o state das views (com cases)
                // self?.genericView
            })
            .subscribe(genericView.emojiImage.rx.image)
            .disposed(by: disposeBag)

        /*viewModel?.emojiImageUrl.bind(listener: { url in
            guard let url = url else { return }
            let dataTask = self.genericView.emojiImage.createDownloadDataTask(from: url)
            dataTask.resume()

             self?.genericView.emojiImage.stopLoading()
        })*/

        /*viewModel?.emojiImageUrl.bind(listener: { url in
            guard let url = url else { return }
            self.genericView.emojiImage.downloadImage(from: url).disposed(by: self.disposeBag)
            self.genericView.emojiImage.stopLoading()
        })*/

        getRandomEmoji()

        self.navigationController?.navigationBar.tintColor = .appColor(name: .primary)

//        genericView.btnEmojisList.addTarget(self, action: #selector(didTapEmojisLIst), for: .touchUpInside)
//        genericView.btnRandomEmoji.addTarget(self, action: #selector(getRandomEmoji), for: .touchUpInside)
//        genericView.btnAvatarsList.addTarget(self, action: #selector(didTapAvatarsList), for: .touchUpInside)
//        genericView.btnAppleRepos.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
//        genericView.btnSearch.addTarget(self, action: #selector(saveSearchContent), for: .touchUpInside)

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
