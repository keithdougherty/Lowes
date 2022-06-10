//
//  URLRequest+Util.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension URLRequest {
    init(components: URLComponents) {
        guard let url = components.url else {
            preconditionFailure("Unable to get URL from URLComponents: \(components)")
        }
        self = Self(url: url)
            .add(headers: ["Content-Type": "application/json"])
    }
    
    private func map( _ transform: (inout Self) -> ()) -> Self {
        var request = self
        transform(&request)
        return request
    }
    
    func add(httpMethod: HTTPMethod) -> Self {
        map { $0.httpMethod = httpMethod.rawValue }
    }
    
    func add<Body: Encodable>(body: Body) -> Self {
        map {
            do {
                $0.httpBody = try JSONEncoder().encode(body)
            } catch {
                preconditionFailure("Failed to encode request body: \(body) due to error: \(error)")
            }
        }
    }
    
    func add(headers: [String:String]) -> Self {
        map {
            let allHTTPHeaders = $0.allHTTPHeaderFields ?? [:]
            let updatedHTTPHeaders = headers.merging(allHTTPHeaders, uniquingKeysWith: { $1 })
            $0.allHTTPHeaderFields = updatedHTTPHeaders
        }
    }
}
