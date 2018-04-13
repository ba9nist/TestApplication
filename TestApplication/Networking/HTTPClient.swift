//
//  HTTPClient.swift
//  JBWTest
//
//  Created by ba9nist on 11.03.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit
import Alamofire

class HTTPClient: NSObject {
    static func sendRequest<T: BaseResponseModelProtocol>(model: BaseRequestModel, handler: T, completion: @escaping (T?, NetworkErrorProtocol?) -> Void) {
        Alamofire.request(model.url, method: model.method, parameters: model.getParameters(), encoding: model.encoding, headers: model.headers).responseJSON { (response) in

            if let json = response.result.value {
                print("response = \(json)")
                switch (response.response!.statusCode) {
                    case 200:
                        handler.parseJSON(json: json)

                        completion(handler, nil)

                        break

                    default:
                        print(json)
                        if json is NSDictionary {
                            let dictionary = json as! NSDictionary
                            completion(nil, NetworkError(json: dictionary))
                        }
                        break
                }
            } else {
                print("error = \(String(describing: response.error?.localizedDescription))")
                completion(nil, NetworkError(description: response.error!.localizedDescription))
            }
        }
    }
}
