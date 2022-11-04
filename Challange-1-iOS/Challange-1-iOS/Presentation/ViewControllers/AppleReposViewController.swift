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

    private var addedToView: Bool = false
    private var isEnd: Bool = false

    var coordinator: Coordinator?
    var viewModel: AppleReposViewModel?

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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpTableView() {
        title = "Apple Repos"
        view.backgroundColor = .appColor(name: .tableSurface)

        tableView.frame = view.bounds
        tableView.backgroundColor = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never

        tableView.register(AppleReposCell.self, forCellReuseIdentifier: AppleReposCell.reuseCellIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.appleReposList.bind(listener: { [weak self] newRepos in
            guard
                let self = self,
                let newRepos = newRepos else { return }
            self.appleRepos = newRepos

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.addedToView = true
                if self.tableView.contentSize.height < self.tableView.frame.size.height {
                    self.viewModel?.getRepos()
                }
                self.tableView.reloadData()
            }
        })
        viewModel?.isEnd.bind(listener: { [weak self] ended in
            guard let self = self else { return }
            self.isEnd = ended
        })
    }
}

// MARK: - UITableViewDataSource
extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y
        let heightVisibleScroll = scrollView.frame.size.height
        let heightTable = scrollView.contentSize.height

        if offset > 0
            && (offset + heightVisibleScroll) > (heightTable - (heightVisibleScroll*0.20))
            && addedToView
            && !isEnd {
            addedToView = false
            viewModel?.getRepos()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleRepos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: AppleReposCell = tableView.dequeueReusableCell(for: indexPath)

        let repos = appleRepos[indexPath.row]

        cell.textLabel?.text = repos.fullName

        return cell
    }

}
