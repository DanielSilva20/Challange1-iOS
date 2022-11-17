//
//  AppleRepos.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/26/22.
//

import UIKit
import RxSwift

class AppleReposViewController: BaseGenericViewController<AppleReposView> {
    weak var delegate: BackToMainViewControllerDelegate?
    private var appleRepos: [AppleRepos] = []

    private var addedToView: Bool = false
    private var isEnd: Bool = false

    var viewModel: AppleReposViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Repos"
        genericView.tableView.dataSource = self
        genericView.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.rxAppleRepos
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { repos in
                self.appleRepos = repos
                self.addedToView = true
                if self.genericView.tableView.contentSize.height < self.genericView.tableView.frame.size.height {
                    self.viewModel?.rxGetRepos()
                }
                self.genericView.tableView.reloadData()
            }, onDisposed: {
                print("APPLE REPOS DISPOSED")
            })
            .disposed(by: disposeBag)
        viewModel?.rxGetRepos()
        //        viewModel?.appleReposList.bind(listener: { [weak self] newRepos in
        //            guard
        //                let self = self,
        //                let newRepos = newRepos else { return }
        //            self.appleRepos = newRepos
        //
        //            DispatchQueue.main.async { [weak self] in
        //                guard let self = self else { return }
        //                self.addedToView = true
        //                if self.genericView.tableView.contentSize.height < self.genericView.tableView.frame.size.height {
        //                    self.viewModel?.getRepos()
        //                }
        //                self.genericView.tableView.reloadData()
        //            }
        //        })
        viewModel?.isEnd.bind(listener: { [weak self] ended in
            guard let self = self else { return }
            self.isEnd = ended
        })
    }

    deinit {
        self.delegate?.navigateBackToMainPage()
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
            viewModel?.rxGetRepos()
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
