//
//  ServiceManager.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(AppConstant.baseURL)?apikey=\(AppConstant.apikey)&s=\(query)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(SearchResponseModel.self, from: data)
                completion(.success(results.search))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getMovieDetails(movieIMDB: String, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        guard let url = URL(string: "\(AppConstant.baseURL)?&i=\(movieIMDB)&apikey=\(AppConstant.apikey)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let movie = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }

    
}
