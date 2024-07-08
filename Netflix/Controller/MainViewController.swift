//
//  MainViewController.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import UIKit

class MainViewController: UIViewController {
    private let homeFeedTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FeedsTableViewCell.self, forCellReuseIdentifier: FeedsTableViewCell.identifier)
        return table
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var viewModel: MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUserInterface()
        self.setUpSearchController()
    }
    
    private func setUpUserInterface() {
        view.addSubview(homeFeedTableView)
        setUpDatasoucreAndDelegate()
    }
    
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setUpDatasoucreAndDelegate() {
        viewModel = MoviesViewModel()
        viewModel?.delegate = self
        homeFeedTableView.dataSource = self
        homeFeedTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
}

// MARK: - Table View DataSource and delegate methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfMovies() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedsTableViewCell.identifier, for: indexPath) as? FeedsTableViewCell else { return UITableViewCell() }
        if let movie = viewModel?.movie(at: indexPath.row) {
            if viewModel?.favMovies.contains(movie.id) ?? false {
                cell.configureFavButton()
            }
            cell.updateFavMoviesList = viewModel?.updateFavMovieList
            cell.configureCell(with: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel?.movies[indexPath.row] else { return }
        viewModel?.getMovieDetailWith(imdbID: movie.imdbID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            viewModel?.clearSearchResults()
            return
        }
        viewModel?.getSearchMovies(searchText: searchText)
    }
}


extension MainViewController: MovieRelaods {
    func reloadTableView() {
        self.homeFeedTableView.reloadData()
    }
    
    func didFetchMovieDetail(_ movieDetail: MovieDetailModel) {
        let detailVC = MovieDetailScreenViewController(movieDetail: movieDetail)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}



