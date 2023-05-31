//
//  MoviesModel.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import Foundation

struct MoviesModel: Codable {
    let items: [MostPopularDetail]
}

struct MostPopularDetail: Codable {
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let imDbRating: String
    let imDbRatingCount: String
}
