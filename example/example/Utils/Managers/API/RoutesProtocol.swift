//
//  RoutesProtocol.swift
//  example
//
//  Created by Nguyen Xuan Tho on 3/10/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRouter {
    static var basePath: String { get }
}

protocol Routable {
    typealias Parameters = [String : Any]
    var route: String {get set}
    init()
}

extension Routable {

    init() {
        self.init()
    }
    
    static func getRoute(_ param: String) -> String {
        let temp = Self.init()
        var route = "\(temp.route)"
        if (!param.isEmpty) {
            route += "/\(param)"
        }
        
        return route
    }
    
}

protocol Readable: Routable {}

extension Readable where Self: Routable {

    static func get(params: String) -> RequestConverter {
        return RequestConverter(method: .get, route: getRoute(params))
    }
    
    static func get() -> RequestConverter {
        return RequestConverter(method: .get, route: getRoute(""))
    }
    
    static func get(params: Parameters) -> RequestConverter {
        RequestConverter(method: .get, route: getRoute(""), parameters: params)
    }
    
    static func get(params: String, parameters: Parameters) -> RequestConverter {
        RequestConverter(method: .get, route: getRoute(params), parameters: parameters)
    }

}

protocol Creatable: Routable {}

extension Creatable where Self: Routable {

    static func create(parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)"
        return RequestConverter(method: .post, route: route)
    }
}

protocol Updatable: Routable {}

extension Updatable where Self: Routable {

    static func update(params: String, parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)/\(params)"
        return RequestConverter(method: .put, route: route, parameters: parameters)
    }
}

protocol Deletable: Routable {}

extension Deletable where Self: Routable {

    static func delete(params: String) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)/\(params)"
        return RequestConverter(method: .delete, route: route)
    }
}

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

        let url = try Router.basePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(route))

        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
