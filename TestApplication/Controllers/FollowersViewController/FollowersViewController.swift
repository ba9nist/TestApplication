//
//  FollowersViewController.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class FollowersViewController: BaseViewController {
    private let identifier = "FollowersTableViewCell"

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var username: String!
    var followers = [GithubUser]()

    var loadedPage = 1;

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false

        infoLabel.text = "Followers of user \(username!):"

        loadFollowers(page: loadedPage)
        loadedPage += 1
    }

    func loadFollowers(page: Int) {
        let model = GetFollowersRequestModel(user: username, page: page)
        HTTPClient.shared.sendRequest(model: model, handler: GetFollowersResponseModel()) { (handler, error) in
            guard error == nil else {
                self.showError(error: error!, retryBlock:nil)
                return
            }

            print(handler!.users.count)
            self.updateData(list: handler!.users)
        }
    }

    func updateData(list: [GithubUser]) {

        var indexPaths = [IndexPath]()
        for (index, _) in list.enumerated() {
            indexPaths.append(IndexPath(row: self.followers.count + index, section: 0))
        }

        let lastUserIndex = self.followers.count - 1
        self.followers.append(contentsOf: list)

        DispatchQueue.main.async {
            self.tableView.insertRows(at: indexPaths, with: .none)
            if lastUserIndex > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: lastUserIndex, section: 0), at: .bottom, animated: true)
            }
        }

    }

}

extension FollowersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.followers.count - 1) {
            loadFollowers(page: loadedPage)
            loadedPage += 1
        }
    }
}

extension FollowersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UserTableViewCell

        let user = followers[indexPath.row]
        cell.setupCell(username: user.login, profileUrl: user.htmlUrl, imageUrl: user.avatarUrl)

        return cell
    }

}
