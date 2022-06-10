//
//  URLComponents+Utl.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

public extension URLComponents {
    init(scheme: String = "https",
         host: String = "api.themoviedb.org",
         path: String,
         queryItems: [URLQueryItem] = []) {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [.apiKey, .englishLanguage, .excludeAdultContext] + queryItems
        self = components
    }
}

extension URLComponents {
    static func searchForMovie(title: String) -> Self {
        let queryItems: [URLQueryItem] = [.query(text: title)]
        return Self(path: "/3/search/movie", queryItems: queryItems)
    }
}
