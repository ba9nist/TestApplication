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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false

        infoLabel.text = "Followers of user \(username!):"

        loadFollowers()
    }

    func loadFollowers() {
        let model = GetFollowersRequestModel(user: username)
        HTTPClient.shared.sendRequest(model: model, handler: GetFollowersResponseModel()) { (handler, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }

            self.followers = handler!.users
            self.tableView.reloadData()
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
