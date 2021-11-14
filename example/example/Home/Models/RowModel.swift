//
//  RowModel.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/3/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation
import SwiftyJSON

class RowModel {
    
    let type: RowType
    let title: String
    var totalPages: Int
    var data: JSON
    var currentPage = 1
    var isLoading = false
    
    init(data: JSON, totalPages: Int, type: RowType) {
        self.data = data
        self.type = type
        self.totalPages = totalPages
        
        switch type {
        case .category:
            self.title = Constants.Localization.Home.category.localized
        case .topRated:
            self.title = Constants.Localization.Home.topRated.localized
        case .upcoming:
            self.title = Constants.Localization.Home.upcoming.localized
        case .popular:
            self.title = Constants.Localization.Home.popular.localized
        case .nowPlaying:
            self.title = Constants.Localization.Home.nowPlaying.localized
        case .header:
            self.title = ""
        case .rate:
            self.title = Constants.Localization.Detail.yourRate.localized
        case .cast:
            self.title = Constants.Localization.Detail.seriesCast.localized
        case .video:
            self.title = Constants.Localization.Detail.video.localized
        case .comment:
            self.title = Constants.Localization.Detail.comments.localized
        case .recomendation:
            self.title = Constants.Localization.Detail.recomendation.localized
        }
    }
    
}
