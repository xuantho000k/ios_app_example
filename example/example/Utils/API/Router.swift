//
//  Router.swift
//  example
//
//  Created by Nguyen Xuan Tho on 1/21/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    var baseUrl: String { get }
    var path: String {get set}
}

extension Routable {
    func getRoute(_ param: String) -> String {
        var route = baseUrl + path
        if (!param.isEmpty) {
            route += "/\(param)"
        }
        
        return route
    }
    
}

protocol Readable: Routable {}

extension Readable {

    func get(params: String) -> RequestConverter {
        return RequestConverter(method: .get, route: getRoute(params))
    }
    
    func get() -> RequestConverter {
        return RequestConverter(method: .get, route: getRoute(""))
    }
    
    func get(params: Parameters) -> RequestConverter {
        RequestConverter(method: .get, route: getRoute(""), parameters: params)
    }
    
    func get(params: String, parameters: Parameters) -> RequestConverter {
        RequestConverter(method: .get, route: getRoute(params), parameters: parameters)
    }

}

protocol Creatable: Routable {}

extension Creatable {

    func create(parameters: Parameters) -> RequestConverter {
        return RequestConverter(method: .post, route: getRoute(""))
    }
}
