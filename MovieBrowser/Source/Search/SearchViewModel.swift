//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine
import UIKit

class SearchViewModel {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Movie>
    
    private let network = Network()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var keywordSearch: String = ""
    @Published var movies: [Movie] = []
    
    @Published private(set) var snapshot = Snapshot()
    
    func searchMovies() {
        network.searchMovies(title: self.keywordSearch)
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)
    }
    
    init() {
        
        $keywordSearch
            .receive(on: RunLoop.main)
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                self?.movies = []
            }
            .store(in: &cancellables)
        
        $keywordSearch
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] _ in
                self?.searchMovies()
            }
            .store(in: &cancellables)
        
        $movies
            .receive(on: DispatchQueue.main)
            .map { items -> Snapshot in
                var retval = Snapshot()
                retval.appendSections([1])
                retval.appendItems(items, toSection: 1)
                return retval
            }
            .assign(to: \SearchViewModel.snapshot, on: self)
            .store(in: &cancellables)
    }
}
