//
//  MovieService.swift
//  example
//
//  Created by Nguyen Xuan Tho on 13/11/2021.
//  Copyright © 2021 ThoNX. All rights reserved.
//

import Foundation

struct MoviesRouter {
    static var root: String {
        let endpoint = Bundle.main.object(forInfoDictionaryKey: "App endpoint") as! String
        
        return endpoint
    }

    static func getPath(sub: String) -> String {
        
        return "/movie" + sub
    }
    
    struct Latest: Readable {
        var path = getPath(sub: "/latest")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct NowPlaying: Readable {
        var path = getPath(sub: "/now_playing")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Popular: Readable {
        var path = getPath(sub: "/popular")
        var baseUrl: String = MoviesRouter.root
    }

    struct TopRated: Readable {
        var path = getPath(sub: "/top_rated")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Upcoming: Readable {
        var path = getPath(sub: "/upcoming")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Detail: Readable {
        var path = getPath(sub: "")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct SeriesCast: Readable {
        var path = getPath(sub: "")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Comment: Readable {
        var path = getPath(sub: "")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Video: Readable {
        var path = getPath(sub: "")
        var baseUrl: String = MoviesRouter.root
    }
    
    struct Recomendation: Readable {
        var path = getPath(sub: "")
        var baseUrl: String = MoviesRouter.root
    }
}

class MovieService {
    
    var api: APIConnection
    
    init(_ api: APIConnection) {
        self.api = api
    }
    
    func getLatestMovies(_ page: Int, completion: @escaping Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.Latest().get(params: p), completion: completion)
    }
    
    func getNowPlaying(_ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.NowPlaying().get(params: p), completion: completion)
    }
    
    func getPopularMovies(_ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.Popular().get(params: p), completion: completion)
    }
    
    func getTopRatedMovies(_ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.TopRated().get(params: p), completion: completion)
    }
    
    func getUpcomingMovies(_ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.Upcoming().get(params: p), completion: completion)
    }
    
    func getMovieDetail(_ movieId: Int, completion: @escaping Connection.Completion) {
        api.makeRequest(MoviesRouter.Detail().get(params: "\(movieId)"), completion: completion)
    }

    func getSeriesCast(_ movieId: Int, completion: @escaping  Connection.Completion) {
        api.makeRequest(MoviesRouter.Recomendation().get(params: "\(movieId)/credits"), completion: completion)
    }
    
    func getComments(_ movieId: Int, _ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.Comment().get(params: "\(movieId)/reviews", parameters: p), completion: completion)
    }
    
    func getVideos(_ movieId: Int, completion: @escaping  Connection.Completion) {
        api.makeRequest(MoviesRouter.Video().get(params: "\(movieId)/videos"), completion: completion)
    }
    
    func getMovieRecomendations(_ movieId: Int, _ page: Int, completion: @escaping  Connection.Completion) {
        let p: [String: Any] = [Constants.Request.page: page]
        
        api.makeRequest(MoviesRouter.Recomendation().get(params: "\(movieId)/recommendations", parameters: p), completion: completion)
    }
}
