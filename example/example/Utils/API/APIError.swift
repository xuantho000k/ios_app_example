//
//  APIError.swift
//  example
//
//  Created by Nguyen Xuan Tho on 1/21/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation

enum APIErrorCode: Int {
    case unknow = 0, noNetwork, timeout, authFailed, jsonSerialization
}

struct APIError {
    var errorCode: APIErrorCode
    var message: String
}
