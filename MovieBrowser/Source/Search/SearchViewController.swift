//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    typealias DiffableDataSource = UITableViewDiffableDataSource<Int, Movie>
    
    // MARK: - Outlets
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchButton: UIButton!
    
    // MARK: - Private varibles
    private let viewModel = SearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var diffableDataSource: DiffableDataSource = { [unowned self] in
        DiffableDataSource(tableView: self.tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell
            cell?.movie = item
            return cell
        }
    }()
    
    // MARK: - Private Functions
    private func setupObservers() {
        self.viewModel.$snapshot
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                self.diffableDataSource.apply($0, animatingDifferences: true)
            }
            .store(in: &self.cancellables)
        
        self.viewModel.$keywordSearch
            .receive(on: RunLoop.main)
            .map{ $0.isEmpty }
            .sink { [weak self] isEmpty in
                guard let self = self else {
                    return
                }
                
                guard isEmpty else {
                    self.tableView.restore()
                    return
                }
                
                self.tableView.setEmptyMessage("Please enter a movie title to begin searching")
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    @IBAction func searchButton_selected(_ sender: Any) {
        self.viewModel.searchMovies()
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.diffableDataSource
        
        setupObservers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movieDetailController = segue.destination as? MovieDetailViewController,
              let cell = sender as? MovieCell else {
            return
        }

        movieDetailController.movie = cell.movie
    }
}

// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.keywordSearch = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.keywordSearch = ""
    }
}
