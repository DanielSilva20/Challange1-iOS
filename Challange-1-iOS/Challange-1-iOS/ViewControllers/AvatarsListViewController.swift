//
//  AvatarsList.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class AvatarsListViewController: UIViewController, Coordinating, AvatarPresenter {
    private var collectionView: UICollectionView
    var coordinator: Coordinator?
    var avatarService: AvatarService?
    var avatarMocked: MockedAvatarStorage?
    var avatarPersistence: AvatarPersistence?
    
//    lazy var collectionView: UICollectionView = {
//        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        return v
//    }()
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
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
    
    private func setUpViews(){
        setUpCollectionView()
    }
    
    private func addViewsToSuperview(){
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        title = "Avatars List"
//        view.backgroundColor = .appColor(name: .surface)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 4
//
//        collectionView = .init(frame: .zero, collectionViewLayout: layout)
//
        collectionView.register(GaleryCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.delegate = self
        collectionView.dataSource = self
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("Avatars: \(String(describing: avatarService?.avatars.count))")
        
    }
    
}

extension AvatarsListViewController: AvatarStorageDelegate {
    func avatarListUpdated() {
        collectionView.reloadData()
    }
}

extension AvatarsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (avatarPersistence?.avatarsPersistenceList.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GaleryCell else {
            return UICollectionViewCell()
        }

        guard let url = avatarPersistence?.avatarsPersistenceList[indexPath.row].value(forKey: "avatarUrl") as? String else { return UICollectionViewCell() }
        
        print("url: \(url)")
        
        cell.setUpCell(url: URL(string: url)!)
        
        return cell
    }
}


extension AvatarsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
