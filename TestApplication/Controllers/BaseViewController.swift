//
//  BaseViewController.swift
//  TestApplication
//
//  Created by ba9nist on 13.04.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }



    func showError(error: NetworkErrorProtocol, retryBlock: (() -> Void)?) {
        print(error.localizedDescription)
        print(error.localizedTitle)
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        if(retryBlock != nil) {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                retryBlock!()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
}
