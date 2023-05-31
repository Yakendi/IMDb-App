//
//  MoviesSearchingModel.swift
//  IMDB
//
//  Created by Аслан Микалаев on 24.05.2023.
//

import Foundation

struct MoviesSearchingModel: Codable {
    let searchType: String
    let expression: String
    let results: [MovieDetails]
}

struct MovieDetails: Codable {
    let image: String
    let title: String
    let description: String
}
