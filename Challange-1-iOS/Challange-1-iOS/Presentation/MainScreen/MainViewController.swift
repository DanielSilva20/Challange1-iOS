import UIKit
import Alamofire
import CoreData

class MainViewController: BaseGenericViewController<MainView> {
    weak var delegate: MainViewControllerDelegate?
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

        viewModel?.emojiImageUrl.bind(listener: { url in
            guard let url = url else { return }
            let dataTask = self.genericView.emojiImage.createDownloadDataTask(from: url)
            dataTask.resume()

             self.genericView.emojiImage.stopLoading()
        })

        getRandomEmoji()

        self.navigationController?.navigationBar.tintColor = .appColor(name: .primary)

        genericView.btnEmojisList.addTarget(self, action: #selector(didTapEmojisLIst), for: .touchUpInside)
        genericView.btnRandomEmoji.addTarget(self, action: #selector(getRandomEmoji), for: .touchUpInside)
        genericView.btnAvatarsList.addTarget(self, action: #selector(didTapAvatarsList), for: .touchUpInside)
        genericView.btnAppleRepos.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
        genericView.btnSearch.addTarget(self, action: #selector(saveSearchContent), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func didTapEmojisLIst(_ sender: UIButton) {
        self.delegate?.navigateToEmojiList()
//        coordinator?.eventOccurred(with: .buttonEmojisListTapped)
    }

    @objc func didTapAvatarsList(_ sender: UIButton) {
        self.delegate?.navigateToAvatarList()
//        coordinator?.eventOccurred(with: .buttonAvatarsListTapped)
    }

    @objc func didTapAppleRepos(_ sender: UIButton) {
        self.delegate?.navigateToAppleRepos()
//        coordinator?.eventOccurred(with: .buttonAppleReposTapped)
    }

    @objc func getRandomEmoji() {
        viewModel?.getRandom()
    }

    @objc func saveSearchContent() {
        viewModel?.searchQuery.value = genericView.searchBar.text
        genericView.searchBar.text = ""
    }
}

// extension MainViewController: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        getRandomEmoji()
//    }
// }
