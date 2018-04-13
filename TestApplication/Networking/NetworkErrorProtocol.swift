//
//  NetworkErrorProtocol.swift
//  JBWTest
//
//  Created by ba9nist on 08.03.2018.
//  Copyright © 2018 ba9nist. All rights reserved.
//

import UIKit

protocol NetworkErrorProtocol: Error {
    var localizedDescription: String { get }
    var localizedTitle: String { get }
}
