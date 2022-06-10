//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

extension URLRequest {
    static func searchMovies(title: String) -> Self {
        .init(components: .searchForMovie(title: title))
            .add(httpMethod: .get)
    }
}

class Network {
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    private let urlSession = URLSession.shared
    
    func searchMovies(title: String) -> AnyPublisher<[Movie], Never> {
        urlSession.publisher(for: .searchMovies(title: title), responseType: Movie.NetworkResponse.self)
            .map(\.results)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}


