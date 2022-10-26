//
//  MockAppleReposDataSource.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 21/10/2022.
//

import UIKit

class MockAppleReposDataSource: NSObject, UITableViewDataSource {
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
