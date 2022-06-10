//
//  SearchMovie.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movie: Identifiable, Hashable, Codable {
    var id: Int
    var title: String
    var releaseDateString: String
    var posterPath: String?
    var overview: String
    var rating: Double
    
    var releaseDateLongString: String? {
        get {
            guard let releaseDate = DateFormatter.stringToDateFormatter.date(from: releaseDateString) else {
                return nil
            }
            return DateFormatter.dateToLongStringFormatter.string(from: releaseDate)
        }
    }
    
    var releaseDateShortString: String? {
        get {
            guard let releaseDate = DateFormatter.stringToDateFormatter.date(from: releaseDateString) else {
                return nil
            }
            return DateFormatter.dateToShortStringFormatter.string(from: releaseDate)
        }
    }
    
    var ratingString: String {
        String(format: "%0.1f", rating)
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case releaseDateString = "release_date"
        case posterPath = "poster_path"
        case rating = "vote_average"
        
        case id
        case overview
    }
}

extension Movie {
    struct NetworkResponse: Codable {
        var results: [Movie]
    }
}
