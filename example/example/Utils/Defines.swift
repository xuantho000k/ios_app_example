//
//  Defines.swift
//  example
//
//  Created by ThoNX on 6/3/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    static let screenSize = UIScreen.main.bounds.size
    static let cornerRadius = CGFloat(6)
    static func getImageURL(_ path: String) -> String {
        return "https://image.tmdb.org/t/p/original" + path
    }

    enum Request {
        static let key = "api_key"
        static let value = "ba8f9ef08851e0a16b8dbd5e8e2ddcb4"
        static let page = "page"
    }
    
    enum Reponse {
        static let result = "results"
        static let poster = "poster_path"
        static let title = "title"
        static let id = "id"
        static let totalPage = "total_pages"
        static let backdrop = "backdrop_path"
        static let overview = "overview"
        static let releaseDate = "release_date"
        static let cast = "cast"
        static let author = "author"
        static let content = "content"
        static let name = "name"
        static let genres = "genres"
        static let profilePath = "profile_path"
    }
    
    enum Image {
        static let search = "ic-search-color"
        static let logo = "logo"
        static let homeUser = "ic-user-main-page"
        static let arrowBlue = "ic-arrow-blue"
    }
    
    enum Localization {
        enum Home {
            static let discover = "HomeScreen.Discover"
            static let tvshow = "HomeScreen.TVShow"
            static let movie = "HomeScreen.Movie"
            static let category = "HomeScreen.Category"
            static let topRated = "HomeScreen.TopRated"
            static let upcoming = "HomeScreen.UpComing"
            static let popular = "HomeScreen.Popular"
            static let nowPlaying = "HomeScreen.NowPlaying"
        }
        
        enum Detail {
            static let readMore = "DetailScreen.Readmore"
            static let favorite = "DetailScreen.Favorite"
            static let yourRate = "DetailScreen.YourRate"
            static let writeAComment = "DetailScreen.WriteAComment"
            static let seriesCast = "DetailScreen.SeriesCast"
            static let video = "DetailScreen.Video"
            static let comments = "DetailScreen.Comments"
            static let recomendation = "DetailScreen.Recomendation"
        }
        
        enum Error {
            static let somethingWentWrong = "Error.SomethingWentWrong"
            static let jsonSerialization = "Error.JsonSerialization"
            static let noNetwork = "Error.NoNetwork"
            static let timeout = "Error.TimeOut"
        }
    }
    
    enum Storyboard {
        enum Name {
            
        }
        
        enum Id {
            static let movieDetail = "MovieDetailViewController"
        }
    }
    
    enum DateFormat {
        static let yyyymmdd = "yyyy-MM-dd"
        static let mmmmyyyy = "MMMM yyyy"
    }
}
