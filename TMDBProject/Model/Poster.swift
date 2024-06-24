//
//  Poster.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/25/24.
//

import Foundation

struct Poster: Decodable {
    let id: Int
    let posters: [PosterResult]
}

struct PosterResult: Decodable {
    let file_path: String
}
