//
//  URLSession+Util.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    func publisher<T: Decodable>(for request: URLRequest, responseType: T.Type = T.self, decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

