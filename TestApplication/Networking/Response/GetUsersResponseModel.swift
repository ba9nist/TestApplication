//
//  GetUsersResponseModel.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class GetUsersResponseModel: BaseResponseModelProtocol {

    var users = [GithubUser]()

    func parseJSON(json: Any) {

        let usersDicts = json as! [NSDictionary]
        for user in usersDicts {
            users.append(GithubUser(json: user))
        }
        
    }
    

}
