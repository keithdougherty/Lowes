//
//  URLQueryItem+Util.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension URLQueryItem {
    static var apiKey: Self {
        Self(name: "api_key", value: Network.apiKey)
    }
    
    static var englishLanguage: Self {
        Self(name: "language", value: "en-US")
    }
    
    static var excludeAdultContext: Self {
        Self(name: "include_adult", value: "false")
    }
    
    static func query(text: String) -> Self {
        Self(name: "query", value: text)
    }
    
    static func page(number: Int) -> Self {
        Self(name: "page", value: String(format: "%d", number))
    }
}
