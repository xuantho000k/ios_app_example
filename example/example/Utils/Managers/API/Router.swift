//
//  Router.swift
//  example
//
//  Created by Nguyen Xuan Tho on 1/21/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation
import Alamofire

//enum Router: URLRequestConvertible {
//    case createUser(parameters: Parameters)
//    case readUser(id: Int)
//    case updateUser(id: Int, parameters: Parameters)
//    case destroyUser(id: Int)
//
//    var method: HTTPMethod {
//        switch self {
//        case .createUser:
//            return .post
//        case .readUser:
//            return .get
//        case .updateUser:
//            return .put
//        case .destroyUser:
//            return .delete
//        }
//    }
//
//    var path: String {
//        switch self {
//        case .createUser:
//            return "/users"
//        case .readUser(let id):
//            return "/users/\(id)"
//        case .updateUser(let id, _):
//            return "/users/\(id)"
//        case .destroyUser(let id):
//            return "/users/\(id)"
//        }
//    }
//
//    func asURLRequest() throws -> URLRequest {
//        let endpoint = Bundle.main.object(forInfoDictionaryKey: "App endpoint") as! String
//        let url = try endpoint.asURL()
//
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//        urlRequest.httpMethod = method.rawValue
//
//        switch self {
//        case .createUser(let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        case .updateUser(_, let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        default:
//            break
//        }
//
//        return urlRequest
//    }
//}
struct Router: URLRouter {
    static var basePath: String {
        
        let endpoint = Bundle.main.object(forInfoDictionaryKey: "App endpoint") as! String
        
        return endpoint
    }
    
    static func getImageURL(_ path: String) -> String {
        
        return "https://image.tmdb.org/t/p/original" + path
    }
    
    struct Movie: Readable {
        
        static func getPath(sub: String) -> String {
            
            return "/movie" + sub
        }
        
        var route = getPath(sub: "")
        
        struct Latest: Readable {
            var route = getPath(sub: "/latest")
        }
        
        struct NowPlaying: Readable {
            var route = getPath(sub: "/now_playing")
        }
        
        struct Popular: Readable {
            var route = getPath(sub: "/popular")
        }
        
        struct TopRated: Readable {
            var route = getPath(sub: "/top_rated")
        }
        
        struct Upcoming: Readable {
            var route = getPath(sub: "/upcoming")
        }
        
    }
}
