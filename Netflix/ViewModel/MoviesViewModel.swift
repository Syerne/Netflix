//
//  MoviesViewModel.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import Foundation

protocol MovieRelaods: AnyObject {
    func reloadTableView()
    func didFetchMovieDetail(_ movieDetail: MovieDetailModel)
}

class MoviesViewModel {
    
    weak var delegate: MovieRelaods?
    var movies: [Movie] = []
    var movieDetail: MovieDetailModel?
    var favMovies: [String]
    
    init() {
        favMovies = UserDefaults.standard.array(forKey: "favMovies")  as? [String] ?? []
        getMovies(searchText: "Don")
    }
    
    func getSearchMovies(searchText: String?) {
        self.getMovies(searchText: searchText)
    }
    
    func getMovieDetailWith(imdbID: String?) {
        self.getMovieDetail(movieImdbID: imdbID)
    }
    
    private func getMovies(searchText: String?) {
        ServiceManager.shared.fetchMovies(query: searchText ?? "Don") { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    print(movies)
                    self?.movies = movies
                    self?.delegate?.reloadTableView()
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
    
    private func getMovieDetail(movieImdbID: String?) {
        ServiceManager.shared.getMovieDetails(movieIMDB: movieImdbID ?? "") { [weak self] result in
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    print(movieDetail)
                    self?.movieDetail = movieDetail
                    self?.delegate?.didFetchMovieDetail(movieDetail)
                }
            case .failure(let error):
                print("Failed to fetch movies details: \(error)")
            }
        }
        
    }
    
    func clearSearchResults() {
        delegate?.reloadTableView()
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie? {
        guard index < movies.count else { return nil }
        return movies[index]
    }
    
    func updateFavMovieList(id: String) {
        if favMovies.contains(id) {
            favMovies.removeAll(where: {$0 == id})
        }
        else {
            favMovies.append(id)
        }
        UserDefaults.standard.setValue(favMovies, forKey: "favMovies")
    }
}
