//
//  GetUsersRequest.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class GetUsersRequestModel: BaseRequestModel {
    
    init() {
        super.init(apiMethod: "users", method: .get)
    }
}
