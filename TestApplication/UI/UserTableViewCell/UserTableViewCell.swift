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
        avatarImageView.image = UIImage(named: "ic_defaultImage")

        HTTPClient.shared.loadImage(url: imageUrl!, completionHandler: { (image, url) in
            if url == imageUrl {
                self.avatarImageView.alpha = 0
                self.avatarImageView.image = image
                UIView.animate(withDuration: 0.5) {
                    self.avatarImageView.alpha = 1.0
                }

            }
        })
    }
    
}
