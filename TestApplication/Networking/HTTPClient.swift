//
//  HTTPClient.swift
//  JBWTest
//
//  Created by ba9nist on 11.03.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HTTPClient: NSObject {
    static let shared = HTTPClient()
    private override init() {

    }

    private let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100*1024*1024,
        preferredMemoryUsageAfterPurge: 60*1024*1024
    )

    private let size = CGSize(width: 100.0, height: 100.0)

    func loadImage(url: String, completionHandler: @escaping (Image, String) -> ()){
        guard let img = getImageFromCache(url: url) else {
            Alamofire.request(url, method:.get).responseImage { (response) in
                guard let image = response.result.value else { return }
                let scaledImage = image.af_imageAspectScaled(toFit: self.size)
                self.imageCache.add(scaledImage, withIdentifier: url)
                completionHandler(scaledImage, url)
            }
            return
        }

        completionHandler(img, url)
    }

    private func getImageFromCache(url: String) ->Image? {
        return imageCache.image(withIdentifier: url)
    }

    func sendRequest<T: BaseResponseModelProtocol>(model: BaseRequestModel, handler: T, completion: @escaping (T?, NetworkErrorProtocol?) -> Void) {
        Alamofire.request(model.url, method: model.method, parameters: model.getParameters(), encoding: model.encoding, headers: model.headers).responseJSON { (response) in

            if let json = response.result.value {
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
