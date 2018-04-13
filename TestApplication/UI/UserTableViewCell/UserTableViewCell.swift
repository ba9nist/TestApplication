//
//  UserTableViewCell.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileUrlLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setupCell(username: String, profileUrl: String, imageUrl: String?) {

        usernameLabel.text = username
        profileUrlLabel.text = profileUrl
    }
    
}
