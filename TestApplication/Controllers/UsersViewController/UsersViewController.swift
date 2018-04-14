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

        self.title = "Github users"

        loadUsers()
    }

    func loadUsers() {
        let model = GetUsersRequestModel()
        HTTPClient.shared.sendRequest(model: model, handler: GetUsersResponseModel()) { (handler, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            self.users = handler!.users
            self.tableView.reloadData()
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

