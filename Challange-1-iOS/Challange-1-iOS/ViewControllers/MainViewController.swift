import UIKit

class BaseGenericView: UIView {
    required init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func setupView() {}
}

class BaseGenericViewController<View: BaseGenericView>: UIViewController {

    var genericView: View {
        view as! View
    }
    
    override func loadView() {
        view = View()
    }
}

class MainView: BaseGenericView {
    func businessLogicOfMain() {}
}

class MainViewController: BaseGenericViewController<BaseGenericView>, Coordinating {
    var coordinator: Coordinator?
    
    private var verticalStackView: UIStackView
    private var searchStackView: UIStackView
    private var btnRandomEmoji: UIButton
    private var btnEmojisList: UIButton
    private var btnAvatarsList: UIButton
    private var btnAppleRepos: UIButton
    private var searchBar: UISearchBar
    private var searchBtn: UIButton
    private var emojiImage: UIImage
    
    init() {
        // 0 - Create the Views
        btnRandomEmoji = .init(type: .system)
        btnEmojisList = .init(type: .system)
        btnAvatarsList = .init(type: .system)
        btnAppleRepos = .init(type: .system)
        searchBtn = .init(type: .system)
        searchBar = .init(frame: .zero)
        searchStackView = .init(arrangedSubviews: [searchBar, searchBtn])
        verticalStackView = .init(arrangedSubviews: [btnRandomEmoji, btnEmojisList, searchStackView, btnAvatarsList, btnAppleRepos])
        emojiImage = .init()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
//        genericView.businessLogicOfMain()
    }
    
    // 1 - SetUp the views
    private func setUpViews() {
        view.backgroundColor = .systemBlue
        view.tintColor = .lightGray
        
        
        verticalStackView.axis = .vertical
        searchStackView.axis = .horizontal
        btnRandomEmoji.setTitle("Random List", for: .normal)
        btnEmojisList.setTitle("Emojis List", for: .normal)
        btnAvatarsList.setTitle("Avatars List", for: .normal)
        btnAppleRepos.setTitle("Apple Repos", for: .normal)
        searchBtn.setTitle("Search", for: .normal)
   
        
        let buttonArray = [btnRandomEmoji, btnEmojisList, searchBtn, btnAvatarsList, btnAppleRepos]
        buttonArray.forEach {
            $0.configuration = .filled()
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        
        btnEmojisList.addTarget(self, action: #selector(didTapEmojisLIst), for: .touchUpInside)
        btnRandomEmoji.addTarget(self, action: #selector(didTapRandomEmoji), for: .touchUpInside)
        btnAvatarsList.addTarget(self, action: #selector(didTapAvatarsList), for: .touchUpInside)
        btnAppleRepos.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
    }
    
    // 2 - Add to superview
    private func addViewsToSuperview() {
        
        view.addSubview(verticalStackView)
    }
    
    // 3 - Set the constraints
    private func setUpConstraints() {
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        verticalStackView.spacing = 20;
        searchStackView.spacing = 20;
    }
    
    @objc func didTapEmojisLIst(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonEmojisListTapped)
    }
    
    @objc func didTapRandomEmoji(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonRandomListTapped)
    }
    
    @objc func didTapAvatarsList(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonAvatarsListTapped)
    }
    
    @objc func didTapAppleRepos(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonAppleReposTapped)
    }
    
}
