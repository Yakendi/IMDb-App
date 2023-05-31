//
//  ServiceFactory.swift
//  IMDB
//
//  Created by Аслан Микалаев on 26.05.2023.
//

import UIKit


final class ServiceFactory {
    
    // MARK: - Singleton
    static let shared = ServiceFactory()
    
    // MARK: - Public
    var networkService: NetworkService
    
    // MARK: - Constructor
    private init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }
    
    // MARK: - Requests
    func getMoviesList(completion: @escaping Handler<MoviesModel>) {
        networkService.makeRequest(to: .movies(), completion: completion)
    }
    
    func getTVsList(completion: @escaping Handler<MoviesModel>) {
        networkService.makeRequest(to: .tvShows(), completion: completion)
    }
    
    func getTopMoviesList(completion: @escaping Handler<MoviesModel>) {
        networkService.makeRequest(to: .topMovies(), completion: completion)
    }
    
    func getTopTVsList(completion: @escaping Handler<MoviesModel>) {
        networkService.makeRequest(to: .topTVs(), completion: completion)
    }
    
    func getSearchingList(with keyWord: String, completion: @escaping Handler<MoviesSearchingModel>) {
        networkService.makeRequest(to: .search(with: keyWord), completion: completion)
    }
}
