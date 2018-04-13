//
//  BaseModel.swift
//  JBWTest
//
//  Created by ba9nist on 03.03.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit
import Alamofire

class BaseRequestModel: NSObject {
    let baseURL = "https://api.github.com/"
    let url: String
    let method: HTTPMethod
    var headers: HTTPHeaders
    let encoding: ParameterEncoding

    init(apiMethod: String, method: HTTPMethod) {
        url = "\(baseURL)\(apiMethod)"
        print(url)
        self.method = method

        encoding = JSONEncoding.default
        headers = [
            "Content-Type": "application/json"
        ]
    }

    func getParameters() -> Parameters? {
        return nil
    }

    func setAccessToken(token: String) {
        headers["Authorization"] = "Bearer \(token)"
    }
}
