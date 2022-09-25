import UIKit

class MainViewController: UIViewController {
    private var verticalStackView: UIStackView
    private var searchStackView: UIStackView
    private var btnRandomEmoji: UIButton
    private var btnEmojisList: UIButton
    private var btnAvatarsList: UIButton
    private var btnAppleRepos: UIButton
    private var searchBar: UISearchBar
    private var searchBtn: UIButton
    
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
    }
    
    // 1 - SetUp the views
    private func setUpViews() {
        view.backgroundColor = .systemBlue
        
        verticalStackView.axis = .vertical
        searchStackView.axis = .horizontal
        btnRandomEmoji.setTitle("Random List", for: .normal)
        btnEmojisList.setTitle("Emojis List", for: .normal)
        btnAvatarsList.setTitle("Avatars List", for: .normal)
        btnAppleRepos.setTitle("Apple Repos", for: .normal)
        searchBtn.setTitle("Search", for: .normal)
        
        let buttonArray = [btnRandomEmoji, btnEmojisList, searchBtn, btnAvatarsList, btnAppleRepos]
        buttonArray.forEach {
            $0.backgroundColor = .gray
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 5.0
        }
        
        btnEmojisList.addTarget(self, action: #selector(didTapEmojisLIst), for: .touchUpInside)
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
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            searchBtn.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        verticalStackView.spacing = 20;
        searchStackView.spacing = 20;
    }
    
    @objc func didTapEmojisLIst(_ sender: UIButton) {
        let destinationController = EmojisListViewController()
        self.present(destinationController, animated: true)
    }
}
