//
//  Request.swift
//  example
//
//  Created by Nguyen Xuan Tho on 13/11/2021.
//  Copyright © 2021 ThoNX. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestConverterProtocol: URLRequestConvertible {
    var method: HTTPMethod {get set}
    var route: String {get set}
    var parameters: Parameters {get set}
}

struct RequestConverter: RequestConverterProtocol {

    var method: HTTPMethod
    var route: String
    var parameters: Parameters = [:]

    init(method: HTTPMethod, route: String, parameters: Parameters = [:]) {
        self.method = method
        self.route = route
        
        var params = parameters
        params[Constants.Request.key] = Constants.Request.value
        
        self.parameters = params
    }

    func asURLRequest() throws -> URLRequest {
        let url = try route.asURL()

        var request = URLRequest(url: url)
        request.method = method

        return try URLEncoding.default.encode(request, with: parameters)
    }
}
