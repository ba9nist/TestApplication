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

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var users = [GithubUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()

        loadUsers()
    }

    func loadUsers() {
        let model = GetUsersRequestModel()
        HTTPClient.sendRequest(model: model, handler: GetUsersResponseModel()) { (handler, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            print("OK")
            self.users = handler!.users
            self.tableView.reloadData()
        }
    }

}

extension UsersViewController: UITableViewDelegate {

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

