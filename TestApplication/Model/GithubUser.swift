//
//  GithubUser.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class GithubUser: NSObject {
    //    "login": "mojombo",
    //    "id": 1,
    //    "avatar_url": "https://avatars0.githubusercontent.com/u/1?v=4",
    //    "gravatar_id": "",
    //    "url": "https://api.github.com/users/mojombo",
    //    "html_url": "https://github.com/mojombo",
    //    "followers_url": "https://api.github.com/users/mojombo/followers",
    //    "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
    //    "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
    //    "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
    //    "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
    //    "organizations_url": "https://api.github.com/users/mojombo/orgs",
    //    "repos_url": "https://api.github.com/users/mojombo/repos",
    //    "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
    //    "received_events_url": "https://api.github.com/users/mojombo/received_events",
    //    "type": "User",
    //    "site_admin": false
    var login: String!
    var id: Int!
    var avatarUrl: String!
    var htmlUrl: String!

    init(json: NSDictionary) {
        login = json.object(forKey: "login") as! String
        id = json.object(forKey: "id") as! Int
        avatarUrl = json.object(forKey: "avatar_url") as! String
        htmlUrl = json.object(forKey: "html_url") as! String
    }
}
