//
//  AppleRepos.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit

class AppleReposViewController: UIViewController, Coordinating {
    private var tableView: UITableView
    private var appleRepos: [AppleRepos] = []
    private var strong: MockedAppleReposDataSource = .init()
    
    var appleReposService: AppleReposService?
    
    private var itemsPerPage:Int = 10
    private var pageNumber: Int = 1
    
    var coordinator: Coordinator?
    
    init() {
        tableView = .init(frame: .zero)
        
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
    
    private func setUpViews() {
        setUpCollectionView()
    }
    
    private func addViewsToSuperview() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        title = "Apple Repos"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AppleReposCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appleReposService?.getAppleReposList(itemsPerPage: itemsPerPage, pageNumber: pageNumber) { (result: Result<[AppleRepos], Error>) in
            switch result {
            case .success(let success):
                self.appleRepos = success
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                print("Error getting appleRepos data \(failure)")
            }
        }
    }
    
}


// MARK: - UITableViewDataSource
extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppleReposCell", for: indexPath)
        
        let repos = appleRepos[indexPath.row]
        
        cell.textLabel?.text = repos.fullName
        return cell
    }
}

// MARK: - MockedDataSource
class MockedAppleReposDataSource: NSObject, UITableViewDataSource {
    var mockedRepos: MockedAppleReposStorage = .init()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockedRepos.appleRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppleReposCell", for: indexPath)
        let repos = mockedRepos.appleRepos[indexPath.row]
        
        cell.textLabel?.text = repos.fullName
        return cell
    }
}
