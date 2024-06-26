//
//  Movie.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import Foundation

struct TrendingMovie: Decodable {
    let results: [MovieResult]
}

struct MovieResult: Decodable {
    let id: Int
    let overview: String
    let poster_path: String?
    let title: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}
