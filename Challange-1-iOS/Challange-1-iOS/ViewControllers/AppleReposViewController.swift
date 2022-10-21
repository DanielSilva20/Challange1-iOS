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
    
    var mockedAppleReposDataSource: MockAppleReposDataSource?
    var appleReposService: AppleReposService?
    
    private var itemsPerPage:Int = 10
    private var pageNumber: Int = 1
    
    private var addedToView: Bool = false
    private var isEnd: Bool = false
    
    
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
        setUpTableView()
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
    
    private func setUpTableView() {
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y
        let heightVisibleScroll = scrollView.frame.size.height
        let heightTable = scrollView.contentSize.height

        if((offset + heightVisibleScroll) > heightTable && addedToView && !isEnd) {
            addedToView = false
            self.pageNumber += 1
            self.appleReposService?.getAppleReposList(itemsPerPage: itemsPerPage, pageNumber: pageNumber, { ( result: Result<[AppleRepos], Error>) in
                switch result {
                case .success(let success):
                    self.appleRepos.append(contentsOf: success)

                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }

                    if success.count < self.itemsPerPage {
                        self.isEnd = true
                    }

                case .failure(let failure):
                    print("[PREFETCH] Error : \(failure)")
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addedToView = true
        return appleRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppleReposCell", for: indexPath)
        
        let repos = appleRepos[indexPath.row]
        
        cell.textLabel?.text = repos.fullName
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        return cell
    }

}
