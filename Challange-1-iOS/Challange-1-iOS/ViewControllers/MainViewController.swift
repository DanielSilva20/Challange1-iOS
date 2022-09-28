import UIKit
import Alamofire

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

extension Array {
    func item(at: Int) -> Element? {
        count > at ? self[at] : nil
    }
}

class MainViewController: BaseGenericViewController<BaseGenericView>, Coordinating {
    var coordinator: Coordinator?
    
    private var verticalStackView: UIStackView
    private var searchStackView: UIStackView
    private var emojiContainer: UIView
    private var btnRandomEmoji: UIButton
    private var btnEmojisList: UIButton
    private var btnAvatarsList: UIButton
    private var btnAppleRepos: UIButton
    private var searchBar: UISearchBar
    private var searchBtn: UIButton
    private var emojiImage: UIImageView
    
    private var urlEmojiImage : String
    
    let url = URL(string: "https://api.github.com/emojis")!

    var emojisList = [Emoji]()
    
    init() {
        // 0 - Create the Views
        btnRandomEmoji = .init(type: .system)
        btnEmojisList = .init(type: .system)
        btnAvatarsList = .init(type: .system)
        btnAppleRepos = .init(type: .system)
        searchBtn = .init(type: .system)
        searchBar = .init(frame: .zero)
        emojiImage = .init(frame: .zero)
        emojiContainer = .init(frame: .zero)
        urlEmojiImage = .init()
        searchStackView = .init(arrangedSubviews: [searchBar, searchBtn])
        verticalStackView = .init(arrangedSubviews: [emojiContainer, btnRandomEmoji, btnEmojisList, searchStackView, btnAvatarsList, btnAppleRepos])

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEmojis()
        
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
        btnRandomEmoji.addTarget(self, action: #selector(getRandomEmoji), for: .touchUpInside)
        btnAvatarsList.addTarget(self, action: #selector(didTapAvatarsList), for: .touchUpInside)
        btnAppleRepos.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
    }
    
    // 2 - Add to superview
    private func addViewsToSuperview() {
        emojiContainer.addSubview(emojiImage)
        
        view.addSubview(verticalStackView)
    }
    
    // 3 - Set the constraints
    private func setUpConstraints() {
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        emojiImage.translatesAutoresizingMaskIntoConstraints = false
        emojiContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            emojiImage.topAnchor.constraint(equalTo: emojiContainer.topAnchor),
            emojiImage.bottomAnchor.constraint(equalTo: emojiContainer.bottomAnchor, constant: -40),
            emojiImage.leadingAnchor.constraint(equalTo: emojiContainer.leadingAnchor, constant: 100),
            emojiImage.trailingAnchor.constraint(equalTo: emojiContainer.trailingAnchor, constant: -100),
            emojiImage.widthAnchor.constraint(equalTo: emojiImage.heightAnchor, multiplier: 1)
            
        ])
        
        verticalStackView.spacing = 20;
        searchStackView.spacing = 20;
    }
    
    @objc func didTapEmojisLIst(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonEmojisListTapped)
    }
    
    @objc func didTapAvatarsList(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonAvatarsListTapped)
    }
    
    @objc func didTapAppleRepos(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .buttonAppleReposTapped)
    }
    
    @objc func getRandomEmoji() {
        let randomNumber = Int.random(in: 0 ... self.emojisList.count)
        
        guard let emoji = emojisList.item(at: randomNumber) else { return }

        urlEmojiImage = emoji.url
        
        let url = URL(string: urlEmojiImage)!
        downloadImage(from: url)
        
        
    }
    
 
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.emojiImage.image = UIImage(data: data)
            }
        }
    }
    
    
    func getEmojis() {

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
                if let array = json {
                    for (emojiName,emojiUrl) in array {
                        self.emojisList.append(Emoji (name: "\(emojiName)", url: "\(emojiUrl)"))
                        print(self.emojisList.count)
                    }
                }
                self.getRandomEmoji()
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }

        task.resume()
    }
   
}

