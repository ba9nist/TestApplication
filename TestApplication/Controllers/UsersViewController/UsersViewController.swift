//
//  UsersViewController.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class UsersViewController: BaseViewController {
    private let identifier = "UsersViewControllerCell"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var users = [GithubUser]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()

        self.title = "Github users"

        loadUsers(lastUserId: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedRowPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRowPath, animated: true)
        }
    }

    func loadUsers(lastUserId: Int) {
        let model = GetUsersRequestModel(lastUserId: lastUserId)
        HTTPClient.shared.sendRequest(model: model, handler: GetUsersResponseModel()) { (handler, error) in
            guard error == nil else {
                self.showError(error: error!, retryBlock: {
                    self.loadUsers(lastUserId: lastUserId)
                })
                return
            }

            self.updateData(list: handler!.users)
        }
    }

    func updateData(list: [GithubUser]) {

        var indexPaths = [IndexPath]()
        for (index, _) in list.enumerated() {
            indexPaths.append(IndexPath(row: self.users.count + index, section: 0))
        }

        let lastUserIndex = self.users.count - 1
        self.users.append(contentsOf: list)

        DispatchQueue.main.async {
            if self.users.count == 0 {
                self.noDataLabel.isHidden = false
            } else {
                self.noDataLabel.isHidden = true
            }

            self.tableView.insertRows(at: indexPaths, with: .none)
            if lastUserIndex > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: lastUserIndex, section: 0), at: .bottom, animated: true)
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "UsersToFollowersSegue") {
            if let vc = segue.destination as? FollowersViewController {
                vc.username = sender as! String
                vc.title = "Followers"
            }
        }
    }

}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UsersToFollowersSegue", sender: users[indexPath.row].login)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.users.count - 1) {
            loadUsers(lastUserId: self.users.last!.id)
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! UserTableViewCell

        let user = users[indexPath.row]
        cell.setupCell(username: user.login, profileUrl: user.htmlUrl, imageUrl: user.avatarUrl)
        return cell
    }
}

