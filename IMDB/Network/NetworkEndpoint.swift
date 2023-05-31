//
//  NetworkEndpoints.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import Foundation

struct Endpoint {
    var path: String
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "imdb-api.com"
        components.path = "/API/" + path
        
        return components.url
    }
}

extension Endpoint {
    static func movies() -> Self {
        Endpoint(path: "MostPopularMovies/k_at6g0i1u")
    }
    
    static func tvShows() -> Self {
        Endpoint(path: "MostPopularTVs/k_at6g0i1u")
    }
    
    static func topMovies() -> Self {
        Endpoint(path: "Top250Movies/k_at6g0i1u")
    }
    
    static func topTVs() -> Self {
        Endpoint(path: "Top250TVs/k_at6g0i1u")
    }
    
    static func search(with keyWord: String) -> Self {
        Endpoint(path: "API/Search/k_at6g0i1u/\(keyWord)")
    }
}
