//
//  NetworkError.swift
//  JBWTest
//
//  Created by ba9nist on 08.03.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class NetworkError: NetworkErrorProtocol {
    let messageKey = "message"

    var localizedDescription: String
    var localizedTitle = "NetworkError"

    init(json: NSDictionary) {
        print(json)
        localizedDescription = json.object(forKey: messageKey) as! String
    }

    init(description: String) {
        self.localizedDescription = description
    }
}
