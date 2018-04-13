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
        print(json)

        let usersDicts = json as! [NSDictionary]

        var counter = 0;
        for user in usersDicts {
            print(counter)
            counter = counter + 1
            users.append(GithubUser(json: user))
        }
        
    }
    

}
