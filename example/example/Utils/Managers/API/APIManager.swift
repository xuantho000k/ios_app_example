//
//  APIManager.swift
//  example
//
//  Created by ThoNX on 5/6/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager {
    
    typealias APICompletion = (JSON?, APIError?) -> Void
    
    static let shared = APIManager()
    
    private let sessionManager: Session
    
    private init() {
        let configuration = URLSessionConfiguration.af.default
        let delegate = SessionDelegate(fileManager: .default)
        let queue = DispatchQueue(label: "com.thonx.alamofire.session.rootQueue")
        let logger = APILogger()
        self.sessionManager = Session(configuration: configuration, delegate: delegate, rootQueue: queue, startRequestsImmediately: true, requestQueue: nil, serializationQueue: nil, interceptor: nil, serverTrustManager: nil, redirectHandler: nil, cachedResponseHandler: nil, eventMonitors: [logger])
    }
    
    private func call(request: URLRequestConvertible, completion: @escaping APICompletion) {
        sessionManager.request(request).validate().responseData { (response) in
            if let error = response.error {
                self.handleError(error, completion)
            } else if let data = response.data {
                self.handleSuccessfulResponse(data, completion)
            } else {
                completion(nil, APIError(errorCode: .unknow, message: Constants.Localization.Error.somethingWentWrong.localized))
            }
        }
    }
    
    private func handleSuccessfulResponse(_ response: Data, _ completion: @escaping APICompletion) {
        if let json = try? JSON(data: response) {
            completion(json, nil)
        } else {
            completion(nil, APIError(errorCode: .jsonSerialization, message: Constants.Localization.Error.jsonSerialization.localized))
        }
    }
    
    private func handleError(_ error: Error, _ completion: @escaping APICompletion) {
        var code: APIErrorCode = .unknow
        var message = error.localizedDescription
        if let afError = error as? AFError,
            let responseCode = afError.responseCode {
            code = APIErrorCode(rawValue: responseCode) ?? .unknow
        } else {
            let nsError = error as NSError
            switch nsError.code {
            case NSURLErrorNotConnectedToInternet:
                code = .noNetwork
                message = Constants.Localization.Error.noNetwork.localized
            case NSURLErrorTimedOut:
                code = .timeout
                message = Constants.Localization.Error.timeout.localized
            default:
                break
            }
        }
        completion(nil, APIError(errorCode: code, message: message))
    }
    
    func getLatestMovies(_ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.Latest.get(params: p), completion: completion)
    }
    
    func getNowPlaying(_ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.NowPlaying.get(params: p), completion: completion)
    }
    
    func getPopularMovies(_ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.Popular.get(params: p), completion: completion)
    }
    
    func getTopRatedMovies(_ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.TopRated.get(params: p), completion: completion)
    }
    
    func getUpcomingMovies(_ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.Upcoming.get(params: p), completion: completion)
    }
    
    func getMovieDetail(_ movieId: Int, completion: @escaping APICompletion) {
        call(request: Router.Movie.get(params: "\(movieId)"), completion: completion)
    }

    func getSeriesCast(_ movieId: Int, completion: @escaping APICompletion) {
        call(request: Router.Movie.get(params: "\(movieId)" + Constants.Path.credit), completion: completion)
    }
    
    func getComments(_ movieId: Int, _ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.get(params: "\(movieId)" + Constants.Path.review, parameters: p), completion: completion)
    }
    
    func getVideos(_ movieId: Int, completion: @escaping APICompletion) {
        call(request: Router.Movie.get(params: "\(movieId)" + Constants.Path.video), completion: completion)
    }
    
    func getMovieRecomendations(_ movieId: Int, _ page: Int, completion: @escaping APICompletion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        call(request: Router.Movie.get(params: "\(movieId)" + Constants.Path.recommendations, parameters: p), completion: completion)
    }
    
}
