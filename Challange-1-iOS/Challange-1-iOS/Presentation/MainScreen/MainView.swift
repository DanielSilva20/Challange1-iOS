//
//  MainView.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/4/22.
//
import UIKit
//
import RxCocoa
import RxSwift

class MainView: BaseGenericView {
    private var verticalStackView: UIStackView
    private var searchStackView: UIStackView
    private var emojiContainer: UIView
    var btnRandomEmoji: UIButton
    var btnEmojisList: UIButton
    var btnAvatarsList: UIButton
    var btnAppleRepos: UIButton
    var btnSearch: UIButton
    var searchBar: UISearchBar
    var emojiImage: UIImageView

    //  Code for RxSwift
    var rxRandomEmojiTap: Observable<Void> { btnRandomEmoji.rx.tap.asObservable() }
    var rxEmojiListTap: Observable<Void> { btnEmojisList.rx.tap.asObservable() }
    var rxAvatarListTap: Observable<Void> { btnAvatarsList.rx.tap.asObservable() }
    var rxAppleReposTap: Observable<Void> { btnAppleRepos.rx.tap.asObservable() }
    var rxSearchTap: Observable<Void> { btnSearch.rx.tap.asObservable() }
    var rxSearchQuery: Observable<String?> { searchBar.rx.text.asObservable() }

    required init() {
        btnRandomEmoji = .init(type: .system)
        btnEmojisList = .init(type: .system)
        btnAvatarsList = .init(type: .system)
        btnAppleRepos = .init(type: .system)
        btnSearch = .init(type: .system)
        searchBar = .init(frame: .zero)
        emojiImage = .init(frame: .zero)
        emojiContainer = .init(frame: .zero)
        searchStackView = .init(arrangedSubviews: [searchBar, btnSearch])
        verticalStackView = .init(arrangedSubviews: [emojiContainer,
                                                     btnRandomEmoji,
                                                     btnEmojisList,
                                                     searchStackView,
                                                     btnAvatarsList,
                                                     btnAppleRepos])
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createViews() {
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
    }

    // 1 - SetUp the views
    private func setUpViews() {

        backgroundColor = .appColor(name: .surface)
        tintColor = .appColor(name: .secondary)

        verticalStackView.axis = .vertical
        searchStackView.axis = .horizontal
        btnRandomEmoji.setTitle("Random List", for: .normal)
        btnEmojisList.setTitle("Emojis List", for: .normal)
        btnAvatarsList.setTitle("Avatars List", for: .normal)
        btnAppleRepos.setTitle("Apple Repos", for: .normal)
        btnSearch.setTitle("Search", for: .normal)

        let buttonArray = [btnRandomEmoji, btnEmojisList, btnSearch, btnAvatarsList, btnAppleRepos]
        buttonArray.forEach {
            $0.configuration = .filled()
        }
    }

    // 2 - Add to superview
    private func addViewsToSuperview() {
        emojiContainer.addSubview(emojiImage)

        addSubview(verticalStackView)
    }

    // 3 - Set the constraints
    private func setUpConstraints() {
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        emojiImage.translatesAutoresizingMaskIntoConstraints = false
        emojiContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            emojiImage.topAnchor.constraint(equalTo: emojiContainer.topAnchor),
            emojiImage.bottomAnchor.constraint(equalTo: emojiContainer.bottomAnchor, constant: -40),
            emojiImage.leadingAnchor.constraint(equalTo: emojiContainer.leadingAnchor),
            emojiImage.trailingAnchor.constraint(equalTo: emojiContainer.trailingAnchor),
            emojiImage.heightAnchor.constraint(equalTo: emojiImage.widthAnchor, multiplier: 0.5)
        ])

        verticalStackView.spacing = 20
        searchStackView.spacing = 20

        emojiImage.contentMode = .scaleAspectFit
    }
}
