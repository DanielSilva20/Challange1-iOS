//
//  AppleReposView.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/7/22.
//

import UIKit

class  AppleReposView: BaseGenericView {
    var tableView: UITableView

    required init() {
        tableView = .init(frame: .zero)

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

    private func setUpViews() {
        backgroundColor = .appColor(name: .tableSurface)

        tableView.frame = bounds
        tableView.backgroundColor = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never

        tableView.register(AppleReposCell.self, forCellReuseIdentifier: AppleReposCell.reuseCellIdentifier)

    }

    private func addViewsToSuperview() {
        addSubview(tableView)
    }

    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
